require 'rails_clafer/meta_clafer'
Dir["./clafer_model/*.rb"].each {|file| require file }
module Clafer
  def self.included(base)
    #class << base
    base.extend(MainMethods)
    #end
  end

  module MainMethods
    def metaclafer 
      @_metaclafer
    end

    def clafer(&block)
      @_metaclafer = Clafer::MetaClafer.new(self)
      CleanRoom.new(self, @_metaclafer).instance_eval(&block) if block_given?
    end
  end

  def self.print
    claferCode = ClaferPrinter.print_clafers self.clafer_module.abstract_clafers
    puts claferCode
    claferCode
  end

  def self.clafer_module
    Rails.application.eager_load!
    clafer_module = ClaferModel::ClaferModule.new ActiveRecord::Base.descendants

  end

  class CleanRoom
    def initialize(model, metaclafer)
      @model = model
      @metaclafer = metaclafer
      #puts "clean room has been create #{@model}"
    end

    def has_many(name, options = {}, &extension)
      #puts "has many has been called"
      association = @model.has_many(name, options, &extension)
      @metaclafer.add_subclafer(name, association)
      association
    end


    def has_and_belongs_to_many(name, options = {}, &extension)
      #puts "has many has been called"
      association = @model.has_and_belongs_to_many(name, options, &extension)
      @metaclafer.add_subclafer(name, association)
      association
    end

    def has_one(name, options= {})
      association = @model.has_one(name, options)
      @metaclafer.add_subclafer(name, association)
      association
    end

    def constraint(constraintString)
      @metaclafer.constraint = constraintString
    end

    def belongs_to(name, options={})
      association = @model.belongs_to(name, options)
      @metaclafer.add_subclafer(name, association)
      association
    end

  end



end


