# frozen_string_literal: true

file = File.read('db/files/recipes-en.json')
recipes = JSON.parse(file)

errors = []

# We iterate over an array of 10 elements. The benchmark below shows that
# there is already a certain benefit in dividing and creating records
# in batches.
# [#<Benchmark::Tms:0x0000000107da58d8
#   @cstime=0.0,
#   @cutime=0.0,
#   @label="create with groups",
#   @real=34.572925000000396,
#   @stime=2.390593,
#   @total=20.027963000000003,
#   @utime=17.637370000000004>,

#  #<Benchmark::Tms:0x00000001085df698
#   @cstime=0.0,
#   @cutime=0.0,
#   @label="create without groups",
#   @real=43.05461099999957,
#   @stime=3.163843,
#   @total=25.890515999999998,
#   @utime=22.726672999999998>]

begin
  recipes.take(10_000).in_groups_of(1_000).each do |recipe_groups|
    recipe_groups.flatten.each do |recipe|
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
      puts "#{recipe['title']} created"
    end
  end
rescue StandardError => e
  errors << "Error: #{e}"
end

begin
  recipes.from(10_000).each do |recipe|
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
    puts recipe['title'] + ' created'
  end
rescue StandardError => e
  errors << "Error: #{e}"
end

puts '====='
puts "#{Recipe.count} records created with #{errors.count} errors: #{errors}"

Recipe.update_search_index
