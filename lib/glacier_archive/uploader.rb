require 'methadone'
require 'yaml'
require 'fog'

module GlacierArchive

  class Uploader 
    
    include Methadone::CLILogging

    def initialize()
      @fog_credentials = get_fog_credentials()
    end
    
    def upload(archive_name)
      warn "#{self.class}#upload is not implemented yet"
    end

    def get_fog_credentials()
      YAML.load(File.read(GlacierArchive.options[:fogrc]))
    end

  end

end
