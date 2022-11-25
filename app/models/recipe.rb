# frozen_string_literal: true

class Recipe < ApplicationRecord
  paginates_per 25

  class << self
    def search_text(query)
      # with multiple words as a query, query terms need to be
      # separated by logical search operator like &, | and ! to be used with
      # with Postgresql's `to_tsquery`.
      if query.is_a? Array
        query = query.join(', ').gsub(', ', ' & ')
      end

      term = sanitize_sql(query)
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
