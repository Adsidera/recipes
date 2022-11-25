# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @params_present = false
    @search_params = params[:query]

    if @search_params
      @recipes = Recipe.search_text(@search_params).order(:title).page params[:page]
      @recipes_count = @recipes.total_count
      @params_present = true
    else
      @recipes = Recipe.where('ratings > ?', 2.0).sample(6)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def search_params
    params.permit(:query)
  end
end
