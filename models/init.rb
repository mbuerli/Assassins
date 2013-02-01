require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite://'+Dir.pwd+'/assassins.db')

require_relative 'profile'
require_relative 'game'
require_relative 'player'

DataMapper.finalize

DataMapper.auto_migrate!
