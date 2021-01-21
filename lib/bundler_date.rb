# frozen_string_literal: true

require "gems"

require_relative "bundler_date/version"

module BundlerDate
  class Command
    # The exec method will be called with the `command_name` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command_name, args)
      specs = Bundler.definition.resolve
      specs.each do |spec|
        msg = "#{spec.name} #{spec.version}"
        versions = Gems.versions(spec.name)
        version = versions.find { |v| v["number"] == spec.version.to_s }
        msg += " #{version["created_at"]}" if version
        Bundler.ui.info msg
      end
    end
  end

  # Register this class as a handler for the `date` command
  Bundler::Plugin::API.command("date", Command)
end
