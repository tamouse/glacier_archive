require 'methadone'
require "glacier_archive/version"
require "glacier_archive/archiver"
require "glacier_archive/uploader"

module GlacierArchive

  extend Methadone::CLILogging

  DEFAULT_OPTIONS = {
    format: 'TGZ',
    verbose: false,
    debug: false,
    vault: "MISSING",
    fogrc: File.join(ENV['HOME'],'.fog'),
  }

  def self.options()
    @options ||= Hash.new
  end

  def self.options=(opts)
    @options=opts.dup.
      tap{|t| debug "#{caller(0,1).first}: Setting GlacierArchive.options to #{t.inspect}"}
  end

end
