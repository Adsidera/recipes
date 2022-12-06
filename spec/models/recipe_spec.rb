# frozen_string_literal: true

require 'rails_helper'
require 'support/database_cleaner'

RSpec.describe Recipe, type: :model do
  before do
    create :recipe
    create :recipe, :salad
    create :recipe, :pudding
    create :recipe, :cake
    Recipe.update_search_index
    Recipe.all.each(&:reload)
  end

  describe '.search_text' do
    subject(:search_text) { described_class.search_text(query).pluck(:title) }

    context 'when querying only one term' do
      context 'when searching in singular form' do
        let(:query) { ['egg'] }

        it 'finds all the recipes with egg' do
          expect(search_text).to match_array ['Golden Sweet Cornbread', 'Banana Pudding']
        end
      end

      context 'when searching in plural form' do
        let(:query) { ['eggs'] }

        it 'finds all the recipes with eggs' do
          expect(search_text).to match_array ['Golden Sweet Cornbread', 'Banana Pudding']
        end
      end
    end

    context 'when querying comma-separated multiple terms' do
      let(:query) { ['egg, flour, bananas'] }

      it 'finds all the recipes with egg' do
        expect(search_text).to match_array ['Banana Pudding', 'Golden Sweet Cornbread']
      end
    end

    context 'when querying multiple single and compound terms' do
      let(:query) { ['salt, baking powder, white sugar'] }

      it 'finds all the recipes with egg' do
        expect(search_text).to match_array ['Golden Sweet Cornbread', 'Sweet Cake']
      end
    end
  end
end
