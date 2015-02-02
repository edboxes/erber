require 'erb'
require 'hashie'

module Erber
  module BindingMixin
    def get_binding
      binding()
    end
  end

  class Templater
    def initialize(template_text)
      @template = ERB.new(template_text, 0, "% <> > -")
    end

    def render(properties_hash)
      mash = Hashie::Mash.new(properties_hash)

      mash.extend BindingMixin

      @template.result(mash.get_binding)
    end
  end
end