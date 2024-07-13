# frozen_string_literal: true

require 'spec_helper'

class RGCIncluded
  include RubyGitCrypt
end

describe RubyGitCrypt do
  commands = {
    add_gpg_user: RubyGitCrypt::Commands::AddGPGUser,
    export_key: RubyGitCrypt::Commands::ExportKey,
    init: RubyGitCrypt::Commands::Init,
    lock: RubyGitCrypt::Commands::Lock,
    status: RubyGitCrypt::Commands::Status,
    unlock: RubyGitCrypt::Commands::Unlock
  }

  it 'has a version number' do
    expect(RubyGitCrypt::VERSION).not_to be_nil
  end

  it 'allows commands to be run without configure having been called' do
    executor = Lino::Executors::Mock.new

    Lino.configure do |config|
      config.executor = executor
    end

    described_class.status

    expect(executor.executions.length).to(eq(1))
  ensure
    Lino.reset!
  end

  describe 'configuration' do
    before do
      described_class.reset!
    end

    it 'logs to standard output by default' do
      expect do
        described_class
          .configuration
          .logger
          .info('Logging with the default logger.')
      end.to output(/Logging with the default logger./).to_stdout
    end

    it 'has info log level by default' do
      expect(described_class.configuration.logger.level).to eq(Logger::INFO)
    end

    it 'allows default logger to be overridden' do
      string_io = StringIO.new
      logger = Logger.new(string_io)
      logger.level = Logger::DEBUG

      described_class.configure do |config|
        config.logger = logger
      end

      described_class
        .configuration
        .logger
        .debug('Logging with a custom logger at debug level.')

      expect(string_io.string)
        .to include('Logging with a custom logger at debug level.')
    end

    it 'has bare git-crypt command as default binary' do
      expect(described_class.configuration.binary).to eq('git-crypt')
    end

    it 'allows binary to be overridden' do
      described_class.configure do |config|
        config.binary = '/path/to/git-crypt'
      end
      expect(described_class.configuration.binary).to eq('/path/to/git-crypt')
    end

    it 'uses whatever $stdout points to for stdout by default' do
      expect(described_class.configuration.stdout).to eq($stdout)
    end

    it 'allows stdout stream to be overridden' do
      stdout = StringIO.new

      described_class.configure do |config|
        config.stdout = stdout
      end

      expect(described_class.configuration.stdout).to eq(stdout)
    end

    it 'uses whatever $stderr points to for stderr by default' do
      expect(described_class.configuration.stderr).to eq($stderr)
    end

    it 'allows stderr stream to be overridden' do
      stderr = StringIO.new

      described_class.configure do |config|
        config.stderr = stderr
      end

      expect(described_class.configuration.stderr).to eq(stderr)
    end

    it 'uses empty string for stdin by default' do
      expect(described_class.configuration.stdin).to(be_nil)
    end

    it 'allows stdin stream to be overridden' do
      stdin = StringIO.new("some\nuser\ninput\n")

      described_class.configure do |config|
        config.stdin = stdin
      end

      expect(described_class.configuration.stdin).to eq(stdin)
    end
  end

  describe 'git-crypt commands' do
    commands.each do |method, command_class|
      describe ".#{method}" do
        let(:parameters) { { user: 'parameters' } }
        let(:invocation_options) do
          { environment: { 'SOME_ENV' => 'SOME_VALUE' } }
        end
        let(:instance) { instance_double(command_class, execute: nil) }

        before do
          allow(command_class).to receive(:new).and_return(instance)
          described_class.send(method, parameters, invocation_options)
        end

        it "creates an instance of the #{command_class} class and calls " \
           'its execute method' do
          expect(instance)
            .to(have_received(:execute)
                  .with(parameters, invocation_options))
        end
      end
    end
  end

  describe 'when included in a class' do
    commands.each_key do |method|
      it "exposes #{method} as a class method on the class" do
        expect(RGCIncluded).to respond_to(method)
      end
    end
  end
end
