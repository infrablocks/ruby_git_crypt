# frozen_string_literal: true

require_relative 'ruby_git_crypt/options'
require_relative 'ruby_git_crypt/version'
require_relative 'ruby_git_crypt/commands'
require 'logger'

module RubyGitCrypt
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset!
      @configuration = nil
    end
  end

  module ClassMethods
    def add_gpg_user(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::AddGPGUser,
           parameters, invocation_options)
    end

    def export_key(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::ExportKey,
           parameters, invocation_options)
    end

    def init(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::Init,
           parameters, invocation_options)
    end

    def lock(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::Lock,
           parameters, invocation_options)
    end

    def status(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::Status,
           parameters, invocation_options)
    end

    def unlock(parameters = {}, invocation_options = {})
      exec(RubyGitCrypt::Commands::Unlock,
           parameters, invocation_options)
    end

    private

    def exec(command_class, parameters, invocation_options)
      command_class.new.execute(parameters, invocation_options)
    end
  end

  extend ClassMethods

  def self.included(other)
    other.extend(ClassMethods)
  end

  class Configuration
    attr_accessor :binary, :logger, :options, :stdin, :stdout, :stderr

    def default_logger
      logger = Logger.new($stdout)
      logger.level = Logger::INFO
      logger
    end

    def default_options
      Options::Factory.new(Options::DEFINITIONS)
    end

    def initialize
      @binary = 'git-crypt'
      @logger = default_logger
      @options = default_options
      @stdin = ''
      @stdout = $stdout
      @stderr = $stderr
    end
  end
end
