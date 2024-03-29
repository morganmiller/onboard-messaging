unless Rails.env.production?
  require "load_scripts/session"

  namespace :load_script do
    desc "Run a load testing script against the app. Accepts 'HOST' as an ENV argument. Defaults to 'localhost:3000'."
    task :run => :environment do
      if `which phantomjs`.empty?
        raise "PhantomJS not found. Make sure you have it installed. Try: 'brew install phantomjs'"
      end
      6.times.map do |i|
        Thread.new do
          puts "Thread #{i} starting..."
          LoadScript::Session.new(ARGV[1]).run
        end
      end.map(&:join)
    end
  end
end
