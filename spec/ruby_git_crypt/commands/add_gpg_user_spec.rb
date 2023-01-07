# frozen_string_literal: true

require 'spec_helper'

describe RubyGitCrypt::Commands::AddGPGUser do
  subcommand = 'add-gpg-user'

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

  it_behaves_like(
    'a command with a flag',
    described_class, subcommand, :no_commit
  )

  it_behaves_like(
    'a command with a flag',
    described_class, subcommand, :trusted
  )

  it_behaves_like(
    'a command with an argument',
    described_class, subcommand, :gpg_user_id
  )
end
