# frozen_string_literal: true

require 'spec_helper'

describe RubyGitCrypt::Commands::Init do
  subcommand = 'init'

  before do
    RubyGitCrypt.configure do |config|
      config.binary = 'path/to/binary'
    end
  end

  after do
    RubyGitCrypt.reset!
  end

  it_behaves_like(
    'a command without a binary supplied',
    described_class, subcommand
  )

  it_behaves_like(
    'a command with an option',
    described_class, subcommand, :key_name
  )
end
