# frozen_string_literal: true

require "gems"
require "terminal-table"

require_relative "bundler_date/ui"
require_relative "bundler_date/version"

module BundlerDate
  class Command
    def exec(_command_name, _args)
      resolve_specs!
      UI.show(ui_rows)
    end

    private

    def ui_rows
      @specs.sort_by(&:name).map do |spec|
        UI::Row.new(
          spec.name, spec.version, spec.date,
          @definition.find_indexed_specs(spec).last.version,
          @definition.find_indexed_specs(spec).last.date
        )
      end
    end

    def resolve_specs!
      @definition = Bundler.definition
      @specs = Bundler.ui.silence { @definition.resolve }
      Bundler.ui.silence { @definition.resolve_remotely! }
    end
  end

  # Register this class as a handler for the `date` command
  Bundler::Plugin::API.command("date", Command)
end
