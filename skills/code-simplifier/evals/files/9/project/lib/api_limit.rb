# frozen_string_literal: true

module ApiLimit
  MAXIMUM = 100

  def self.apply(requested)
    [Integer(requested), MAXIMUM].min
  rescue ArgumentError, TypeError
    MAXIMUM
  end
end
