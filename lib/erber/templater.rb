require 'erb'
require 'hashie'

module Erber
  module BindingMixin
    def get_binding
      binding()
    end
  end

  class Templater
    def initialize(template_text, mash_type = Hashie::Mash)
      @template = ERB.new(template_text, 0, "% <> > -")
      @mash_type = mash_type
    end

    def render(properties_hash)
      mash = @mash_type.new(properties_hash)

      mash.extend BindingMixin

      @template.result(mash.get_binding)
    end
  end
end