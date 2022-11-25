require 'rails_helper'
require 'support/recipes'
require 'support/capybara'

describe 'Recipes: Index', type: :request do
  subject(:request) { get '/recipes', params: params }

  let(:page) { Capybara.fragment(response.body) }

  before do
    sample_create!
  end

  before { request }

  context 'with queried search param' do
    let(:params) { {query: ['eggs']} }

    it 'response returns results containing the query' do
      expect(page).to have_text '4 Found'
      expect(page).to have_text 'Clear the search'
    end
  end
end