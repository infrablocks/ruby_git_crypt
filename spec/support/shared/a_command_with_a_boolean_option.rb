# frozen_string_literal: true

shared_examples(
  'a command with a boolean option'
) do |command_klass, subcommand, option|
  name = "--#{option.to_s.gsub('_', '-')}"

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason: "includes #{name} true when the #{option} option is true",
    expected: "git-crypt #{subcommand} #{name} true",
    binary: 'git-crypt',
    parameters: {
      option => true
    }
  )

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason: "includes #{name} false when the #{option} option is false",
    expected: "git-crypt #{subcommand} #{name} false",
    binary: 'git-crypt',
    parameters: {
      option => false
    }
  )
end
