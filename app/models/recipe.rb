require 'sanitizer'

class Recipe < ApplicationRecord
  paginates_per 24

  class << self
    def search_text(query)
      # `to_tsquery` is not so flexible with compound words`
      # Query terms need to be
      # separated by logical search operator like &, | and ! to be used with
      # with Postgresql's `to_tsquery`.
      cleaned_query = Sanitizer.adjust_compounds_for_sql(query.first).join(' & ')
      term = sanitize_sql(cleaned_query)
      where("tsv @@ to_tsquery('#{term}')")
    end

    def update_search_index
      query = <<~SQL.squish
        UPDATE recipes SET tsv = to_tsvector(coalesce(ingredients::text, ''));
      SQL
      connection.update(query, 'update recipe search index', [])
    end
  end
end
