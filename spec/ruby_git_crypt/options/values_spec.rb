# frozen_string_literal: true

require 'spec_helper'

describe RubyGitCrypt::Options::Values do
  describe '.boolean' do
    it 'builds a boolean value' do
      expect(described_class.boolean('true'))
        .to(eq(RubyGitCrypt::Options::Values::Boolean.new('true')))
    end
  end

  describe '.string' do
    it 'builds a string value' do
      expect(described_class.string('/some/path'))
        .to(eq(RubyGitCrypt::Options::Values::String.new('/some/path')))
    end
  end

  describe '.complex' do
    it 'builds a complex value' do
      expect(described_class.complex([1, 2, 3]))
        .to(eq(RubyGitCrypt::Options::Values::Complex.new([1, 2, 3])))
    end
  end

  describe '.key_value' do
    it 'builds a key value value' do
      expect(described_class.key_value('thing', [1, 2, 3]))
        .to(eq(RubyGitCrypt::Options::Values::KeyValue.new(
                 'thing', [1, 2, 3]
               )))
    end
  end

  describe '.resolve' do
    it 'returns Values::String for :string' do
      expect(described_class.resolve(:string))
        .to(eq(RubyGitCrypt::Options::Values::String))
    end

    it 'returns Values::Complex for :complex' do
      expect(described_class.resolve(:complex))
        .to(eq(RubyGitCrypt::Options::Values::Complex))
    end

    it 'returns Values::Boolean for :boolean' do
      expect(described_class.resolve(:boolean))
        .to(eq(RubyGitCrypt::Options::Values::Boolean))
    end

    it 'returns Values::KeyValue for :key_value' do
      expect(described_class.resolve(:key_value))
        .to(eq(RubyGitCrypt::Options::Values::KeyValue))
    end

    it 'returns provided value otherwise' do
      expect(described_class.resolve(Object))
        .to(eq(Object))
    end
  end
end
