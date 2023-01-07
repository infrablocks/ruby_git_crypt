# frozen_string_literal: true

shared_examples(
  'a command with an argument'
) do |command_klass, subcommand, argument|
  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "calls the git-crypt #{subcommand} command passing the supplied " \
      "#{argument} value",
    expected: "git-crypt #{subcommand} argument-value",
    binary: 'git-crypt',
    parameters: {
      argument => 'argument-value'
    }
  )
end
