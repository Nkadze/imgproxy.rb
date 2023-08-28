require "imgproxy/trim_array"
require "imgproxy/options_casters/float"
require "imgproxy/options_casters/integer"

module Imgproxy
  module OptionsCasters
    # Casts BlurRegion option
    module BlurRegion
      using TrimArray

      # :x0:y0:x1:y1:sigma
      def self.cast(raw)
        raw = [raw].flatten

        casted_result = []
        raw.each do |r|
          next if [r[:x0], r[:y0], r[:x1], r[:y1], r[:sigma]].any?(&:blank?)

          casted_result += [
            Imgproxy::OptionsCasters::Float.cast(r[:x0]) || 0,
            Imgproxy::OptionsCasters::Float.cast(r[:y0]) || 0,
            Imgproxy::OptionsCasters::Float.cast(r[:x1]) || 0,
            Imgproxy::OptionsCasters::Float.cast(r[:y1]) || 0,
            Imgproxy::OptionsCasters::Integer.cast(r[:sigma]),
          ]
        end

        casted_result.trim!
      end
    end
  end
end
