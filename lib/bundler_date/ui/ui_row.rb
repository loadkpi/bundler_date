# frozen_string_literal: true

require "date"

module BundlerDate
  module UI
    class Row
      UNDEFINED = "undefined"
      HEADERS   = [
        "Gem", "Current", "Current Date", "Latest", "Latest Date", "Days between"
      ].freeze

      def initialize(gem_name, current_version, current_date, latest_version, latest_date)
        @gem_name        = gem_name.to_s
        @current_version = current_version.to_s
        @current_date    = Date.parse(current_date.to_s) if current_date
        @latest_version  = latest_version.to_s
        @latest_date     = latest_date ? Date.parse(latest_date.to_s) : ""
        @latest_date     = Date.parse(latest_date.to_s) if latest_date
      end

      def to_ary
        [
          @gem_name,
          @current_version,
          @current_date || UNDEFINED,
          @latest_version,
          @latest_date || UNDEFINED,
          days_between || UNDEFINED
        ]
      end

      private

      def days_between
        return unless @current_date.is_a?(Date) && @latest_date.is_a?(Date)

        (@latest_date - @current_date).to_i
      end
    end
  end
end
