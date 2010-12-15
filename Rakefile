require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "bbpush"
    gem.summary = %Q{A simple server-side Blackberry push notification client that works with BIS applications.}
    gem.description = %Q{BBPush is a simple server-side Blackberry push notification client that works with any BIS applications, regardless of it is in development or in production. All you need to use it are the Blackberry PINS of the devices you want to reach and a few configuration properties that you can get from the BB app developer. The library makes it trivial to send push notifications, be it for one PIN, multiple PINs or even all devices that have your app installed.}
    gem.email = "info@nicholasbrochu.com"
    gem.homepage = "http://github.com/nbrochu/bbpush"
    gem.authors = ["Nicholas Brochu"]
    
    gem.files = [
        "lib/bbpush.rb",
        "lib/bbpush/client.rb",
        "LICENSE",
        "README.textile",
        "VERSION"]

  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bulkdom #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
