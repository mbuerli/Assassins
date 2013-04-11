require 'data_mapper'

DataMapper::Logger.new('sql.log', :debug)
DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/assassins.db')

require_relative 'profile'
require_relative 'game'
require_relative 'player'
require_relative 'course'

DataMapper.finalize

DataMapper.auto_migrate!
