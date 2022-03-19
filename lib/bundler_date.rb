# frozen_string_literal: true

require "terminal-table"

require_relative "bundler_date/spec"
require_relative "bundler_date/spec_list"
require_relative "bundler_date/ui"
require_relative "bundler_date/version"

module BundlerDate
  class Command
    def exec(_command_name, _args)
      UI.show(ui_rows)
    end

    private

    def ui_rows
      spec_list = SpecList.new
      spec_list.all.map do |spec|
        UI::Row.new(
          spec.name,
          spec.version,
          spec.date,
          spec.active_spec_list.last.version,
          spec.active_spec_list.last.date
        )
      end.compact
    end
  end

  Bundler::Plugin::API.command("date", Command)
end
