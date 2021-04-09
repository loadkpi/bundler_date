# frozen_string_literal: true

require_relative "ui/terminal_table"
require_relative "ui/ui_row"

module BundlerDate
  module UI
    module_function

    def show(ui_rows)
      msg = TerminalTable.new(Row::HEADERS, ui_rows)
      Bundler.ui.info msg.to_str
    end
  end
end
