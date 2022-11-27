require 'rails_helper'

describe 'Recipes: Index', type: :system do
  before do
    create :recipe
    create :recipe, :salad
    create :recipe, :pudding
    create :recipe, :cake
    Recipe.update_search_index
    Recipe.all.each(&:reload)
    driven_by(:selenium_chrome_headless)
  end

  it 'displays the recipes page and search recipes' do
    visit '/'

    expect(page).to have_button 'Search'
    page.find('input[type="text"]').fill_in with: 'salt, baking powder, white sugar'
    click_button 'Search'

    expect(page).to have_content 'Found'
    expect(page).to have_button 'Clear the search'
    expect(page).to have_content 'Golden Sweet Cornbread'
    expect(page).to have_content 'Sweet Cake'

    click_button 'Clear the search'

    expect(page).not_to have_content 'Found'
    expect(page).not_to have_content 'Clear the search'

    page.find('input[type="text"]').fill_in with: 'soy-sauce'
    click_button 'Search'

    expect(page).to have_content "Sorry, We couldn't find a recipe for that!"
    expect(page).to have_content 'Tip: avoid hyphens and accents, if you can ;'
  end
end