# frozen_string_literal: true

module BundlerDate
  module UI
    class TerminalTable
      def initialize(headings, ui_rows)
        @table = ::Terminal::Table.new(headings: headings, rows: ui_rows.map(&:to_ary)).tap do |t|
          t.style = { border_x: "", border_y: "", border_i: "" }
        end
      end

      def to_str
        @table.render
      end
    end
  end
end
