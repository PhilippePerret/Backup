
require 'clir'

APP_FOLDER    = File.dirname(__dir__)
BACKUP_FOLDER = mkdir(File.join(APP_FOLDER,'backups'))

Dir["#{__dir__}/classes/*.rb"].each{|m|require m}
