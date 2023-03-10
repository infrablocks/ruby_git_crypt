# frozen_string_literal: true

require 'spec_helper'

describe RubyGitCrypt::Commands::Status do
  subcommand = 'status'

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
    'a command with a flag',
    described_class, subcommand, :encrypted_only, flag: '-e'
  )

  it_behaves_like(
    'a command with a flag',
    described_class, subcommand, :unencrypted_only, flag: '-u'
  )

  it_behaves_like(
    'a command with a flag',
    described_class, subcommand, :fix
  )

  it_behaves_like(
    'a command with an argument array',
    described_class, subcommand, :files
  )
end
