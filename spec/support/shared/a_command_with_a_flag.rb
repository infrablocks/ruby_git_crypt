# frozen_string_literal: true

shared_examples(
  'a command with a flag'
) do |command_klass, subcommand, option, opts = {}|
  name = opts[:flag] || "--#{option.to_s.gsub('_', '-')}"

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason: "includes the #{name} flag when the #{option} option is true",
    expected: "git-crypt #{subcommand} #{name}",
    binary: 'git-crypt',
    parameters: {
      option => true
    }
  )

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "does not include the #{name} flag when the #{option} option is false",
    expected: "git-crypt #{subcommand}",
    binary: 'git-crypt',
    parameters: {
      option => false
    }
  )
end
