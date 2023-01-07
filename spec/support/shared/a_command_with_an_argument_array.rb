# frozen_string_literal: true

shared_examples(
  'a command with an argument array'
) do |command_klass, subcommand, argument|
  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "calls the git-crypt #{subcommand} command passing no arguments " \
      "when #{argument} not provided",
    expected: "git-crypt #{subcommand}",
    binary: 'git-crypt',
    parameters: {}
  )

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "calls the git-crypt #{subcommand} command passing no arguments " \
      "when #{argument} is empty",
    expected: "git-crypt #{subcommand}",
    binary: 'git-crypt',
    parameters: {
      argument => []
    }
  )

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "calls the git-crypt #{subcommand} command passing the supplied value " \
      "k=v from #{argument}",
    expected: "git-crypt #{subcommand} k=v",
    binary: 'git-crypt',
    parameters: {
      argument => ['k=v']
    }
  )

  it_behaves_like(
    'a valid command line',
    command_klass,
    reason:
      "calls the git-crypt #{subcommand} command passing the supplied values " \
      "k1=v1, k2=v2 from #{argument}",
    expected: "git-crypt #{subcommand} k1=v1 k2=v2",
    binary: 'git-crypt',
    parameters: {
      argument => %w[k1=v1 k2=v2]
    }
  )
end
