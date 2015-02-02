require 'json'
require 'yaml'

require 'trollop'
require 'deep_merge'

require 'erber/templater'

module Erber
  module CLI
    def self.go
      parser = Trollop::Parser.new do
        opt :property_file, "Property file to include (JSON or YAML)", :type => :string, :multi => true
        opt :override_property, "'dotted.key.name=value' property to inject.", :type => :string, :multi => true
      end

      opts = parser.parse(ARGV)
      filenames = parser.leftovers

      if filenames.length != 1
        $stderr.puts "Usage: erber [-p props1.yaml [-p props2.json [...]]] [-o foo=bar [-o baz.boop=beep [...]]] template.erb"
        Kernel.exit(1)
      end

      templater = Erber::Templater.new(IO.read(filenames[0]))

      props = {}
      opts[:property_file].each do |property_file|
        case File.extname(property_file)
          when ".yaml"
            props.deep_merge!(YAML.load(IO.read(property_file)))
          when ".json"
            props.deep_merge!(JSON.parse(IO.read(property_file)))
          else
            $stderr.puts "ERROR: unrecognized property format '#{property_file}'."
            Kernel.exit(1)
        end
      end

      props.deep_merge!(unroll_flat_properties(opts[:override_property].map { |o| o.split("=", 2) } ))

      puts templater.render(props)
    end


    def self.unroll_flat_properties(overrides)
      hash_trees = overrides.map do |main_key, main_value|
        main_key.to_s.split(".").reverse.inject(main_value) do |value, key|
          {key.to_s => value}
        end
      end

      retval = {}
      hash_trees.each { |h| retval.deep_merge!(h) }
      retval
    end
  end
end