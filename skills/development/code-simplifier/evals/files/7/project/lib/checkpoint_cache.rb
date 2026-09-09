# frozen_string_literal: true

class CheckpointCache
  def initialize
    @offset = nil
  end

  def write(offset)
    @offset = offset
  end

  def read
    @offset
  end

  def clear
    @offset = nil
  end
end
