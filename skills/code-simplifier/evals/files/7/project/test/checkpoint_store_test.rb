# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require_relative "../lib/checkpoint_store"

class CheckpointStoreTest < Minitest::Test
  def with_store
    Dir.mktmpdir do |directory|
      path = File.join(directory, "checkpoint")
      yield CheckpointStore.new(path), path
    end
  end

  def test_checkpoint_survives_reconstruction
    with_store do |store, path|
      store.write(12)

      assert_equal 12, CheckpointStore.new(path).read
    end
  end

  def test_missing_or_corrupt_checkpoint_recovers_to_zero
    with_store do |store, path|
      assert_equal 0, store.read

      File.write(path, "invalid")
      assert_equal 0, CheckpointStore.new(path).read
    end
  end

  def test_clear_retires_the_checkpoint
    with_store do |store, path|
      store.write(12)
      store.clear

      refute File.exist?(path)
      assert_equal 0, CheckpointStore.new(path).read
    end
  end
end
