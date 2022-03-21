# frozen_string_literal: true

module BundlerDate
  class SpecList
    attr_reader :definition

    def initialize
      @definition = Bundler.definition
      Bundler.ui.silence { definition.resolve }
      Bundler.ui.silence { definition.resolve_remotely! }
      @specs = definition.specs
    end

    def all
      specs.sort_by(&:name)
    end

    def specs
      @specs.map { |s| Spec.new(s) }
    end
  end
end
