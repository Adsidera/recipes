require 'capybara/rspec'

module Capybara
  def self.fragment(html_string)
    Capybara.string(Nokogiri::HTML.fragment(html_string))
  end
end
