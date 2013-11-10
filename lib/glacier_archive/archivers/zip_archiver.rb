
require 'methadone'

module GlacierArchive

  class ZipArchiver
    
    include Methadone::CLILogging
    
    def initialize()
      
    end
    
    def archive(dir)
      warn "#{self.class}#archive not implemented yet!"
      true
    end

  end

end

