require 'active_support/time'

module Lazy
  class TimeRangeError < StandardError; end
  class TimeRange < Range
    def initialize(*args)
      if (args.size == 1) && (args.first.class == Range)
        @range = args.first
      elsif args.size == 2
        @range = args.first..args.last
      else
        raise ArgumentError, 'Expected 1 to 2 arguments'
      end
      super(@range.first, @range.last)
    end

    def to_a(**args)
      super unless first.class == Time

      res = args[:res] || :day
      raise TimeRangeError, "#{res} is not a correct iterator resolution" unless 1.respond_to?(res.to_sym)

      time = first
      output = []
      while (time += 1.send(res)) <= last
        output.push time
      end
      output
    end
  end
end
