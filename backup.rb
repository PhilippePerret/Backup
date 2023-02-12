#!/usr/bin/env ruby -U

begin
  require_relative 'lib/required'
  Backup.run
rescue Exception => e
  puts e.message.rouge
  puts e.backtrace.join("\n").rouge
end
