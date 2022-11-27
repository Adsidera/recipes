# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { 'Golden Sweet Cornbread' }
    ingredients { '1 cup all-purpose flour - 1 cup yellow cornmeal - ⅔ cup
    white sugar - 1 teaspoon salt - 3 ½ teaspoons baking powder - 1 egg - 1 cup milk
    - ⅓ cup vegetable oil' }

    trait :salad do
      title { 'Boring Salat' }
      ingredients { '1 tablespoon vinegar - 1 bunch green salad' }
    end

    trait :pudding do
      title { 'Banana Pudding' }
      ingredients { '1 cup flour - 3 eggs - 2 bananas' }
    end

    trait :cake do
      title { 'Sweet Cake' }
      ingredients { '1 pinch salt - 1 teaspoon baking powder - 1 cup white sugar'}
    end
  end
end