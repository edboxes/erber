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
      end

      opts = parser.parse(ARGV)
      filenames = parser.leftovers

      if filenames.length != 1
        $stderr.puts "Usage: erber [-p props1.yaml [-p props2.json [...]]] template.erb"
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

      puts templater.render(props)
    end
  end
end