# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  add_filter '/spec/'
end

require 'bundler/setup'
require 'faker'

require 'ruby_git_crypt'

O = RubyGitCrypt::Options

Dir[File.join(__dir__, 'support', '**', '*.rb')]
  .sort
  .each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
