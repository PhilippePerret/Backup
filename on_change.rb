#!/usr/bin/env ruby -U
require_relative 'lib/required'


logpath = File.join(APP_FOLDER,'backup.log')
File.open(logpath,'a') do |f|
  f.puts "--- #{Time.now}"
  f.puts "    ARGV = #{ARGV.inspect}"

  begin
    Backup.require_and_run('do_backup')
    Backup.require_and_run('cleanup_backups')
  rescue Exception => e
    f.puts "FATAL ERROR: #{e.message}"
    f.puts e.backtrace.join("\n")
  end
end


