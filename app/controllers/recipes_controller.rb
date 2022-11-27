# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @params_present = false # This will return useful in the views
    @search_params = params[:q]

    if @search_params.present?
      @recipes = Recipe.search_text(@search_params).order(:title).page params[:page]
      @recipes_count = @recipes.total_count
      @params_present = true
      # Reset the params to be able to accept new terms and avoid malformed queries, ie. StatementInvalid errors
      @search_params = nil
    else
      # Attention! `sample` returns an array and not an AR relation
      @recipes = Recipe.where('ratings > ?', 2.0).sample(6)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def search_params
    params.permit(:q)
  end
end
