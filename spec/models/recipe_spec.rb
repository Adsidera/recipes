# frozen_string_literal: true

require 'rails_helper'
require 'support/recipes'

RSpec.describe Recipe, type: :model do
  before { sample_create! }

  describe '.search_text' do
    subject(:search_text) { described_class.search_text query }

    context 'when querying only one term' do
      context 'when searching in singular form' do
        let(:query) { 'egg' }

        it 'finds all the recipes with egg' do
          expect(search_text.count).to eq 4
        end
      end

      context 'when searching in plural form' do
        let(:query) { 'eggs' }

        it 'finds all the recipes with eggs' do
          expect(search_text.count).to eq 4
        end

        it 'finds the same results of a query with a singular form' do
          expect(search_text.pluck(:title)).to eq Recipe.search_text('egg').pluck(:title)
        end
      end
    end

    context 'when querying comma-separated multiple terms' do
      let(:query) { ['egg, flour, bananas']}

      it 'finds all the recipes with egg' do
        expect(search_text.count).to eq 1
      end
    end

    context 'when querying multiple single and compound terms' do
      let(:query) { ['salt, vanilla extract,  white sugar']}

      it 'finds all the recipes with egg' do
        expect(search_text.count).to eq 1
      end
    end
  end
end
