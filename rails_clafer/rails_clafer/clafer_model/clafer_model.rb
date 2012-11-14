module ClaferModel
	class ClaferModel
		def	initialize(ruby_models = [])
			@ruby_models = ruby_models
			@ruby_class_mapping = Hash[@ruby_models.collect {|klass| [klass.name, klass]}]
			_assoc_mapping
			@clafers = Clafer.from_models(self, @ruby_models) 
			@clafer_mapping = Hash[@clafers.collect {|clafer| [clafer.name, clafer]}]
		end
		def clafer_abstract?(clafer_class_name)
			belongs = @assoc_dst[clafer_class_name]
			if belongs
				belongs.size > 1				
			else
				true
			end
		end
		def abstract_clafers
			@clafers.select {|clafer| clafer.is_abstract?}
		end
		def ruby_class_by_name(name)
			@ruby_class_mapping[name]
		end
		def clafer_by_name(name)
			@clafer_mapping[name]
		end
		def assoc_has
			@assoc_src
		end
		def assoc_belong
			@assoc_dst
		end
		private
		def _assoc_mapping
			@assoc_src = {}
			@assoc_dst = {}
			@ruby_models.each do |model_class|
				metaclafer = model_class.metaclafer if model_class.respond_to?(:metaclafer)
				if metaclafer
					metaclafer.subclafers.each do |name, subclafer|
						assoc = subclafer[:association]
						dst = assoc.class_name
						src = model_class.name
						(@assoc_src[src] ||= []) << assoc
						(@assoc_dst[dst] ||= []) << assoc
					end
				end
			end	
		end
	end

end
