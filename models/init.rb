require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite::memory:')#'sqlite://project.db')

require_relative 'profile'

DataMapper.finalize
