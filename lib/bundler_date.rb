# frozen_string_literal: true

require_relative "bundler_date/version"

module BundlerDate
  class Command
    # The exec method will be called with the `command_name` and the `args`.
    # This is where you should handle all logic and functionality
    def exec(command_name, args)
      specs = Bundler.definition.resolve
      specs.each { |spec| Bundler.ui.info spec.name }
      # gem = Bundler::CLI::Common.select_spec("rspec")
      # definition = Bundler.definition(true)
      # p definition.find_resolved_spec(gem).platform
    end
  end

  # Register this class as a handler for the `date` command
  Bundler::Plugin::API.command("date", Command)
end
