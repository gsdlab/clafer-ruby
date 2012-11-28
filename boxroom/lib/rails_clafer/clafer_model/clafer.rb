module ClaferModel
  class Clafer
    class << self
      def model_belong_to_mult_models?(clafer_module, class_name)
        if clafer_module.assoc_belong.has_key? class_name 
          if clafer_module.assoc_belong[class_name].size>1
            true
          else 
            false
          end
        else 
          true
        end
      end

      def dfs (assoc_map, class_name, path, target, abs_model_map)
        if assoc_map.has_key? class_name
          assoc_map[class_name].each do |assoc|
            if assoc.class_name == target
              abs_model_map.merge! path
            else      
              if !path.has_key? assoc.class_name
                dfs(assoc_map, assoc.class_name, path.merge({assoc.class_name => true}), target, abs_model_map)
              end
            end
          end
        end
      end

      def calc_abstract_clafer_list(clafer_module)
        abs_model_map = Hash[clafer_module.ruby_models.collect {|klass| [klass.name, false] }]
        #first pass to check if ruby model belongs to more than one model
        abs_model_map.each do |class_name, is_abstract|
          if model_belong_to_mult_models? clafer_module, class_name
            abs_model_map[class_name] = true
          end
        end
        # second pass to look for circular associations
        abs_model_map.each do |class_name, is_abstract|
          if !is_abstract 
            dfs(clafer_module.assoc_has, class_name, {class_name => true}, class_name, abs_model_map )
          end
        end
        abs_model_map
      end

      def from_models(clafer_module, ruby_models)
        # create clafer for each metaclafer and assoc dst if not already exists
        class_mapping = filter_models clafer_module, ruby_models
        abs_model_map = calc_abstract_clafer_list clafer_module
        class_mapping.collect do |name, klass|
          metaclafer = klass.metaclafer if (klass.respond_to?(:metaclafer))
          clafer = new clafer_module, name, klass, abs_model_map[name]
          clafer.constraint = metaclafer.constraint if metaclafer
          clafer
        end
      end

      def filter_models(clafer_module, ruby_models)
        explicit_clafer_list = Hash[ruby_models.select { |model_class|
          model_class.respond_to?(:metaclafer)
        }.collect {|model_class| 
          [model_class.name, model_class] }]

        implicit_clafer_list = Hash[clafer_module.assoc_belong.select { |name, assoc|
          !explicit_clafer_list.has_key? name
        }.collect { |name, assoc| 
          [name, clafer_module.ruby_class_by_name(name)]	}]

        explicit_clafer_list.merge(implicit_clafer_list)
      end

    end

    attr_accessor :is_abstract
    alias_method :is_abstract?, :is_abstract
    attr_accessor :name, :card, :gcard, :constraint
    def initialize(clafer_module, name, ruby_class, is_abstract)
      @clafer_module = clafer_module
      @is_abstract = is_abstract
      @name = name
      @klass = ruby_class
      @gcard = GCard.new
      @card = Card.new
      @constraint = ""
    end
    
    def subclafers
      @subclafers ||= subclafer_list
    end
    private 
    def subclafer_list
      if @clafer_module.assoc_has.has_key?(@name)
        @clafer_module.assoc_has[@name].collect do |assoc|
          dst_clafer_name = assoc.class_name
          clafer = @clafer_module.clafer_by_name(dst_clafer_name)
          #if @clafer_module.clafer_abstract?(dst_clafer)
          if clafer.is_abstract?
            RefClafer.from_assoc(assoc, clafer)
          else
            SubClafer.from_assoc(assoc, clafer)
          end
        end
      else 
        []			
      end
    end
  end
end
