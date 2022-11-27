# README

This application lets you find recipes from a list of ingredients that you have at home.
It is powered by Rails 7, Postgresql, a very basic Tailwind UI and a pinch of Stimulus.

You can see its demo on Heroku [here](https://new-recipe-finder.herokuapp.com/).

Just type your ingredients in the searchbox, separated by commas. Beware of hyphens, though!

## Local configuration

You need Rails 7.0.4, Ruby 3.1.2 and Postgres installed to run this application locally.
After setting and migrating the database, you need to `rails db:seed` to populate the
database with the recipes from the `json` file.

## Technical decisions

There are 10013 recipes stored in this application, each of them having multiple ingredients.
In the original `json` file, ingredients were listed as an array of strings like `[1 tablespoon olive oil`, `1 medium eggplant, sliced into 1/2-inch rounds]`, ie. as an array of unpredictably verbose strings.
Not to mention that the real ingredients are present in different inflections or even as compound nouns.

This meant that I had to use a more refined query, one that could skip all inflections and directly find the
common lexemes - and that ideally had index support, too.
I therefore chose to use Postgres' full-text search functionality, implemented through the `tsvector` data format and the `to_tsquery` function.

Here below you can find the schema I used for the `recipes` table.

As you notice, the `ingredients` column is a `String` data format - combining the ingredients in just one string, all separated by an hyphen, is maybe a personal choice, but it simplified the implementation of the query for me.

### Database schema

```ruby
  create_table :recipes do |t|
        t.string :title
        t.integer :cook_time
        t.integer :prep_time
        t.string :ingredients
        t.float :ratings
        t.string :cuisine
        t.string :category
        t.string :author
        t.string :image
        t.tsvector :tsv
        t.index :tsv, using: :gin

        t.timestamps
  end
```

## Caching
I preferred not to use low-level caching for caching SQL queries that mostly change all the time. There is already an index on the queried `tsv` column, which stores the preprocessed lexemes optimized for search. Maybe with a different UI, eg. with checkboxes using same queries for the most common ingredients (milk, flour, eggs, etc.), I would have implemented some low-level caching.

## There is no JS, but just a sprinkle
Of Stimulus, for resetting the URL to its original state. Although the real resetting of the search params happens in the controller, it is nice to have a cleaner url, when typing in the search field.

## Testing
I have implemented a unit test for the `Recipe` model and a system test for the integrated search experience.
