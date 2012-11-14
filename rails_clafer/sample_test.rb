#!/usr/bin/ruby

require 'rubygems'
gem 'activerecord'

require 'sqlite3'
require 'active_record'
require './clafer_printer.rb'
require './ar_clafer.rb'

ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => 'test.db'
)

class User < ActiveRecord::Base
	include Clafer
	clafer do
		has_many :problems
	end
end

class Problem < ActiveRecord::Base
	belongs_to :users
end



puts "Printing Clafer model"
ClaferPrinter.print_clafers Clafer.clafer_model.abstract_clafers  

#Output:
#Printing Clafer model
#User
#    Problem

