require 'rubygems'
require 'commander'

class MyApplication
  include Commander::Methods

  def run
    program :name, 'Foo Bar'
    program :version, '1.0.0'
    program :description, 'Stupid command that prints foo or bar.'

    command :foo do |c|
      c.syntax = 'foobar foo'
      c.description = 'Displays foo'
      c.action do |args, options|
        say 'foo'
      end
    end

    run!
  end
end

MyApplication.new.run if $0 == __FILE__

