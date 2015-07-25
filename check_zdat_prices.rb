#!/usr/bin/ruby

##  #!/usr/bin/env ruby
 
require 'rubygems'
require 'commander'
require 'mysql2'
require 'set'

class MyApplication

  include Commander::Methods

  SYMBOL = "MSFT"


  def run
   
    program :version, '0.0.1'
    program :description, 'Verifies data in ZDAT_TRADES.'
 
    default_command :verify_zdat_prices

    command :verify_zdat_prices do |c|
      c.syntax = '<app> [options]'
      c.summary = 'Verifies ZDAT_PRICES of SYMBOL'
      c.description = c.summary # Because we're lazy
      c.example 'Verifies GWPH', '<app> -s GWPH '
      c.option '-s', '--symbol SYMBOL', String, 'Specify a symbol' # Option aliasing
      c.option '-d', '--date DATE', String, 'Specify a date' # Option aliasing
      c.action do |args, options|
        #name = args.shift # or args.first or args[0] if you wish
        puts "Verifying #{options.symbol}!"
        # Or in a real app, you would call a method and pass command line arguments to it.
        run_query options.symbol, options.date
      end
    end
 
    command :goodbye do |c|
      c.syntax = 'my-app goodbye NAME [options]'
      c.summary = 'Says goodbye'
      c.description = c.summary
      c.example 'Say goodbye to world', 'my-app goodbye -n world'
      c.example 'Say goodbye to world', 'my-app goodbye --name world'
      c.option '-n', '--name NAME', String, 'Specify a name' # Option aliasing
      c.action do |args, options|
        puts "Hello #{options.name}!"
      end
    end

    run!
  end

  
  
  
  #
  #   Read all ZDAT_TRADES for a certain day
  #   Calculate OPEN and CLOSE from  opening_time and closing_time
  #   Calculate CHG
  #   Calculate HIGH and LOW
  #   Calculate intraday Volatility
  #   Calculate <other interesting stuff> ?
  #   Verify data (no sudden jumps). Remove data before and after trading?
  #
  #
  
  def run_query (s, d)
    puts "Running #{s} #{d}!"

      client = Mysql2::Client.new(:host => "alphatrading.dnsalias.com", :username => "alpha", :password => "alpha", :database => "alpha")

      symbol = s
      dt = d # "2014-10-16"
      tm = "17:00:00"

      qry = "select " +
      "  symbol, TIME(FROM_UNIXTIME(ts / 1000)), dt, price,size  from zdat_trades " +
      "where " +
      "  symbol = '#{symbol}' " +
      "AND " +
      "  dt = '#{dt}'  " 
  
      params = client.query(qry)
      
      params.each do |x|
        puts x["symbol"] + " " + x["price"].to_s
      end
      puts params.size # 28598 for MSFT
    end
end


puts "Instantiate"
MyApplication.new.run if $0 == __FILE__
