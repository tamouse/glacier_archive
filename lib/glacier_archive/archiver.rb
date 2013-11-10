require 'methadone'
require 'tmpdir'

module GlacierArchive

  class Archiver 
    
    # NOTE: Thought about making this a Singleton, decided against.

    include Methadone::CLILogging

    attr_accessor :archiver
    
    # NOTE: using convention over configuration:
    # archivers live under the 'archivers' directory,
    # with the file name of "format_archiver.rb".
    # The class name is "FormatArchiver".

    ARCHIVERS_DIR = 'archivers'
    ARCHIVERS_SUFFIX = 'Archiver'
    ARCHIVERS_PATTERN = "_#{ARCHIVERS_SUFFIX.downcase}.rb"

    # class function!
    def self.derive_name(format)
      "#{format.capitalize}#{ARCHIVERS_SUFFIX}"
    end

    # class function!
    def self.derive_file_name(format)
      "#{format.downcase}#{ARCHIVERS_PATTERN}"
    end

    def initialize
      load_archivers
      @archiver = choose_archiver(GlacierArchive.options[:format])
      @tempdest = Dir.mktmpdir
      info "Using archiver: #{@archiver.class}"
      self
    end
    
    def cleanup()
      FileUtils.rm_rf(@tempdest)
    end

    # loads up the archivers available
    # returns nil
    def load_archivers
      archivers_dir = File.join(File.dirname(__FILE__),ARCHIVERS_DIR)
      debug "#{caller(0,1).first}: Archivers Directory: #{archivers_dir}"
      archivers = Dir[File.join(archivers_dir,"**","*#{ARCHIVERS_PATTERN}")]
      debug "#{caller(0,1).first}: Archivers: #{archivers.inspect}"
      raise "No archivers found in #{archivers_dir}!" if archivers.empty?
      archivers.each{|file| require file}.tap{|t| debug "#{caller(0,1).first}: Archivers Loaded: #{t.inspect}"}
      nil
    end


    # selects which archiver to use based on format
    # returns the new archiver object
    def choose_archiver(format)
      begin
        archiver_class = GlacierArchive.const_get(self.class.derive_name(format))
      rescue NameError => e
        raise "No archiver for #{format} has been written yet"
      end
      archiver_class.new
    end

    
    # archives the directory based on the format
    # returns the archive file name
    def archive(dir)
      @archiver.archive(dir)
    end

  end

end
