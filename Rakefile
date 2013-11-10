def dump_load_path
  puts $LOAD_PATH.join("\n")
  found = nil
  $LOAD_PATH.each do |path|
    if File.exists?(File.join(path,"rspec"))
      puts "Found rspec in #{path}"
      if File.exists?(File.join(path,"rspec","core"))
        puts "Found core"
        if File.exists?(File.join(path,"rspec","core","rake_task"))
          puts "Found rake_task"
          found = path
        else
          puts "!! no rake_task"
        end
      else
        puts "!!! no core"
      end
    end
  end
  if found.nil?
    puts "Didn't find rspec/core/rake_task anywhere"
  else
    puts "Found in #{path}"
  end
end
require 'bundler'
require 'rake/clean'

begin
require 'rspec/core/rake_task'
rescue LoadError
dump_load_path
raise
end

require 'cucumber'
require 'cucumber/rake/task'
gem 'rdoc' # we need the installed RDoc gem, not the system one
require 'rdoc/task'

include Rake::DSL

Bundler::GemHelper.install_tasks


RSpec::Core::RakeTask.new do |t|
  # Put spec opts in a file named .rspec in root
end


CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty --no-source -x"
  t.fork = false
end

Rake::RDocTask.new do |rd|
  
  rd.main = "README.rdoc"
  
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
end

task :default => [:spec,:features]


desc "Create a new archiver"
task :new_archiver, :format do |t,args|
  require 'glacier_archive/archiver'
  raise "Must give a format" unless args.format
  format = args.format
  content = %Q{
require 'methadone'

module GlacierArchive

  class #{GlacierArchive::Archiver.derive_name(format)}
    
    include Methadone::CLILogging
    
    def initialize()
      
    end
    
    def archive(dir)
      warn "\#{self.class}#archive not implemented yet!"
      true
    end

  end

end

}
  file = File.join(File.dirname(__FILE__), 'lib', 'glacier_archive',
                   GlacierArchive::Archiver::ARCHIVERS_DIR,
                   GlacierArchive::Archiver.derive_file_name(format))
  raise "#{file} already exists! aborting" if File.exists? file

  File.write(file,content)
  puts "Created #{file} for new archiver"
end

