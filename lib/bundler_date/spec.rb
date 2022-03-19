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
            .select {|s| s.match_platform(spec.platform) }
            .sort_by(&:version)
    end

    def method_missing(meth, *args)
      if @spec.respond_to?(meth)
        @spec.send(meth, *args)
      else
        super
      end
    end

    def respond_to?(meth)
      @spec.respond_to?(meth)
    end
  end
end
