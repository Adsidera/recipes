RSpec.configure do |config|
  config.before(:each, type: :model) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, type: :model) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end