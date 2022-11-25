# frozen_string_literal: true

FILE = File.read('spec/support/files/sample_recipes.json')

def sample_create!
  recipes = JSON.parse FILE
  recipes.each do |recipe|
    Recipe.create(
      title: recipe['title'],
      cook_time: recipe['cook_time'],
      prep_time: recipe['prep_time'],
      ingredients: recipe['ingredients'].join(' - '),
      ratings: recipe['ratings'],
      cuisine: recipe['cuisine'],
      category: recipe['category'],
      author: recipe['author'],
      image: recipe['image']
    )
  end
  Recipe.update_search_index
end