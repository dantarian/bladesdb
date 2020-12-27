Before do
    Cucumber::Rails::World.use_transactional_tests = true
end

Before('@javascript') do
    Cucumber::Rails::World.use_transactional_tests = false
    DatabaseCleaner.strategy = :truncation, {:except => %w[current_character_statuses]}
end
