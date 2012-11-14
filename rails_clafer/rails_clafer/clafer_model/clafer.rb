module ClaferModel
	class Clafer
		class << self

			def from_models(clafer_model, ruby_models)
				# create clafer for each metaclafer and assoc dst if not already exists
				class_mapping = filter_models clafer_model, ruby_models

				class_mapping.collect do |name, klass|
					clafer = new clafer_model, klass
					clafer.is_abstract = clafer_model.clafer_abstract?(name)
					clafer
				end
			end
			def filter_models(clafer_model, ruby_models)
				explicit_clafer_list = Hash[ruby_models.select { |model_class|
					model_class.respond_to?(:metaclafer)
				}.collect {|model_class| 
					[model_class.name, model_class] }]

				implicit_clafer_list = Hash[clafer_model.assoc_belong.select { |name, assoc|
					!explicit_clafer_list.has_key? name
				}.collect { |name, assoc| 
					[name, clafer_model.ruby_class_by_name(name)]	}]

				explicit_clafer_list.merge(implicit_clafer_list)
			end
		end

		attr_accessor :is_abstract
		alias_method :is_abstract?, :is_abstract
		attr_reader :name
		def initialize(clafer_model, ruby_class)
			@clafer_model = clafer_model
			@is_abstract = false
			@name = ruby_class.name
		end
		def subclafers
			@subclafers ||= subclafer_list
		end
		private 
		def subclafer_list
			if @clafer_model.assoc_has.has_key?(@name)
				@clafer_model.assoc_has[@name].collect do |assoc|
					dst_clafer_name = assoc.class_name
					clafer = @clafer_model.clafer_by_name(dst_clafer_name)
					#if @clafer_model.clafer_abstract?(dst_clafer)
					if clafer.is_abstract?
						RefClafer.new(assoc.name, clafer)
					else
						SubClafer.new(clafer) 
					end
				end
			else 
				[]			
			end
		end
	end
end
