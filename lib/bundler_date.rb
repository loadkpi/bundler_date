# frozen_string_literal: true

require "gems"
require "terminal-table"

require_relative "bundler_date/version"

module BundlerDate
  class Command
    UI_UNSUPPORTED   = "unsupported"
    UI_UNDEFINED     = "undefined"
    UI_TABLE_HEADERS = [
      "Gem", "Current", "Current Date", "Latest", "Latest Date", "Days between"
    ].freeze

    # The exec method will be called with the `command_name` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command_name, args)
      table = Terminal::Table.new(
        headings: UI_TABLE_HEADERS,
        rows: msg_rows
      )
      Bundler.ui.info table
    end

    private

    def msg_rows
      specs = Bundler.definition.resolve
      specs.map do |spec|
        current_version = spec.version.to_s
        latest_version  = Gems.latest_version(spec.name)["version"]
        if latest_version == "unknown" || !spec.source.is_a?(Bundler::Source::Rubygems)
          next unsupported_msg(spec.name, current_version)
        end

        versions = Gems.versions(spec.name)

        latest_date = versions.find do |v|
          break Date.parse(v["created_at"]) if v["number"] == latest_version.to_s
        end
        current_date =
          if latest_version == current_version
            latest_date
          else
            versions.find { |v| break Date.parse(v["created_at"]) if v["number"] == current_version }
          end
        days_between = (latest_date - current_date).to_i if latest_date && current_date

        [
          spec.name,
          current_version,
          current_date || UI_UNDEFINED,
          latest_version,
          latest_date || UI_UNDEFINED,
          days_between || UI_UNDEFINED,
        ]
      end
    end

    def unsupported_msg(spec_name, current_version)
      [spec_name, current_version, *([UI_UNSUPPORTED] * (UI_TABLE_HEADERS.size - 2))]
    end
  end

  # Register this class as a handler for the `date` command
  Bundler::Plugin::API.command("date", Command)
end
