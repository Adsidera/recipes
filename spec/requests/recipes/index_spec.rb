require 'rails_helper'
require 'support/recipes'
require 'capybara/rspec'
require 'support/capybara'

describe 'Recipes: Index', type: :system do
  subject(:search_request) { get '/recipes', params: params }

  let(:redirect_to_root) { get '/' }
  let(:page) { Capybara.fragment(response.body) }
  let(:session) { Capybara.page }

  before do
    sample_create!
  end

  before { search_request }

  context 'with queried search param' do
    let(:params) { { query: ['eggs'] } }

    it 'response returns results containing the query' do
      expect(page).to have_text '8 Found'
      expect(page).to have_text 'Clear the search'

      within page.find('.btn-secondary') do
        click 'Clear the search'
      end

      expect(session).to have_current_path('/')

    end
  end
end