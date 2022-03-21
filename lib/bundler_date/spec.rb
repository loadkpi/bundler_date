# frozen_string_literal: true

module BundlerDate
  class Spec
    attr_reader :spec

    def initialize(spec)
      @spec = spec
    end

    def active_spec_list
      @active_spec_list ||=
        spec.source.specs
            .search(spec.name)
            .select { |s| s.match_platform(spec.platform) }
            .sort_by(&:version)
    end

    def method_missing(method_name, *args)
      if @spec.respond_to?(method_name)
        @spec.send(method_name, *args)
      else
        super
      end
    end

    def respond_to_missing?(method_name, *args)
      @spec.respond_to?(method_name) or super
    end
  end
end
