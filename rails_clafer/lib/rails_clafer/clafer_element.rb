module RailsClafer
  class ClaferElement
    class << self
      def model_belong_to_mult_models?(class_name)
        if ClaferModel.assoc_dst.has_key? class_name 
          if ClaferModel.assoc_dst[class_name].size>1
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
            if assoc.dst == target
              abs_model_map.merge! path
            else      
              if !path.has_key? assoc.dst
                dfs(assoc_map, assoc.dst, path.merge({assoc.dst => true}), target, abs_model_map)
              end
            end
          end
        end
      end

      def calc_abstract_clafer_list()
        abs_model_map = Hash[ClaferModel.rails_models.collect {|klass| [ClaferModel.claferize_name(klass.name), false] }]
        #first pass to check if ruby model belongs to more than one model
        abs_model_map.each do |class_name, is_abstract|
          if model_belong_to_mult_models? class_name
            abs_model_map[class_name] = true
          end
        end
        # second pass to look for circular associations
        abs_model_map.each do |class_name, is_abstract|
          if !is_abstract 
            dfs(ClaferModel.assoc_src, class_name, {class_name => true}, class_name, abs_model_map )
          end
        end
        abs_model_map
      end

      def from_rails_models(rails_models)
        # create clafer for each metaclafer and assoc dst if not already exists
        class_mapping = Hash[rails_models.collect {|model_class| [ ClaferModel.claferize_name(model_class.name), model_class] }]
        abs_model_map = calc_abstract_clafer_list

        class_mapping.collect do |name, klass|
          new name, klass, abs_model_map[name]
        end
      end
    end


    attr_accessor :is_abstract
    alias_method :is_abstract?, :is_abstract
    attr_accessor :name, :card, :gcard, :constraint
    def initialize(name, ruby_class, is_abstract)
      @is_abstract = is_abstract
      @name = ClaferModel.claferize_name name
      @klass = ruby_class
      @gcard = GCard.new
      @card = Card.new
      @constraint = ""
    end

    def children
      @children ||= children_list
    end
    private 
    def children_list
      if ClaferModel.assoc_src.has_key?(@name)
        ClaferModel.assoc_src[@name].collect do |assoc|
          dst_clafer_name = assoc.dst
          clafer = ClaferModel.clafer_by_name(dst_clafer_name)
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
