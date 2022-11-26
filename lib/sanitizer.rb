# frozen_string_literal: true
class Sanitizer
  def self.adjust_compounds_for_sql(string)
    arr = string.split(', ')
    arr.each do |term|
      term.gsub!(/^\s/, '') if term.scan(/^\s/)
      term.gsub!(/\s/, ' % ') if term.scan(/\s/)
      term.gsub!(/\s/, '') if term.scan(/\s/)
    end
    arr
  end
end