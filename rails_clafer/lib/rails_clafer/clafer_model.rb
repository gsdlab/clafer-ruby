require 'rails_clafer/gcard'
require 'rails_clafer/card'
require 'rails_clafer/clafer_element'
require 'rails_clafer/association'
require 'rails_clafer/ref_clafer'
require 'rails_clafer/sub_clafer'


module RailsClafer
  class ClaferModel
    class << self
      def init(settings)

      end

      def assoc_src
        @assoc_src ||= associations.inject({}) do |result, assoc| 
          (result[assoc.src] ||= []) << assoc
          result
        end
      end

      def assoc_dst
        @assoc_dst ||= associations.inject({}) do |result, assoc| 
          (result[assoc.dst] ||= []) << assoc
          result
        end 
      end

      def abstract_clafers
        @abstract_clafers ||= clafers.select{|clafer| clafer.is_abstract?}
      end

      def clafer_by_name(name)
        @clafer_map ||= Hash[clafers.collect {|clafer| [clafer.name, clafer]}]
        @clafer_map[name]
      end

      def associations
        @associations ||= rails_models.collect { |model| 
          model.reflect_on_all_associations.select { |ar_assoc|
            !ar_assoc.belongs_to?
          }.collect{ |ar_assoc| 
            Association.from_ar_assoc(model, ar_assoc)
          }
        }.flatten
      end

      def clafers
        @clafers ||= ClaferElement.from_rails_models rails_models
      end

      def rails_models
        @rails_models ||= ActiveRecord::Base.descendants
      end

      def claferize_name(class_name)
        class_name.to_s.gsub("::", "__")
      end
    end

  end
end
