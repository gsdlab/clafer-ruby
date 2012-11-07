module Clafer

  def self.included mod
    class << mod
      def metaclafer 
        @_metaclafer
      end

      def clafer_model(top)
        @_metaclafer = MetaClafer.new(self, top)
        puts self.name
        yield if block_given?
      end

      def default_clafer_opts
        {
          :gcard => {:min=>0,:max=>"*"},
          :card => {:min=>1, :max=>"1"},
          :superclafer => nil,
          :is_abstract => true
        }
      end	
      def detect_clafer_options( needle )
      end

      def subclafer_ref( ref_name, clafer_name, options ={})
        options =  default_clafer_opts.merge(options)
        @_metaclafer.add_ref_clafer ref_name, clafer_name, options
        puts "defined clafer ref #{ref_name}"
      end

      def subclafer( clafer_name, options = {} )
        options =  default_clafer_opts.merge(options)
        @_metaclafer.add_subclafer clafer_name
        puts "defined subclafer #{clafer_name}"
      end

      def subclafers( *args )
        args.each do |subclafer|
          @_metaclafer.add_subclafer subclafer, defaults_clafer_opts
          puts "defined subclafer #{subclafer}"
        end
      end

      def subclafers_of_type(type, *args)
        options = default_clafer_opts.merge({"superclafer"=>type})
        args.each do |subclafer|
          @_metaclafer.add_subclafer(subclafer, options)
        end
      end

    end
  end

end


