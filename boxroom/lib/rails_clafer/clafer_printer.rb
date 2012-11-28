module ClaferPrinter
  class << self 
    def print_clafers(list)
      out = ""
      list.each do |clafer|
        out << print_clafer(clafer, 0)
      end
      out 
    end

    def print_clafer(clafer, indent_level)
      whitespace =   build_whitespace(indent_level)
      out = whitespace
      if clafer.respond_to?(:ref_name)
        out << print_ref_clafer(clafer)
      elsif clafer.respond_to?(:name)
        out << print_reg_clafer(clafer)
      end
      out << "\n"
      if clafer.respond_to?(:subclafers)
        subclafers = clafer.subclafers
        subclafers.each do |subclafer|
          out << print_clafer(subclafer, indent_level + 1)
        end
      end
      out << print_constraint(indent_level + 1, clafer.constraint) unless clafer.constraint.blank?
      out

    end
    def print_abstract(clafer)
      if clafer.is_abstract?
        "abstract "
      else 
        ""
      end
    end

    def build_whitespace(indent_level)
      ' ' * indent_level * 4
    end

    def print_constraint(indent_level, constraint)
      out = build_whitespace(indent_level)
      out << constraint
      out << "\n"
      out
    end

    def print_reg_clafer(clafer)
      "#{print_gcard(clafer.gcard)}#{print_abstract(clafer)}#{clafer.name} #{print_card(clafer.card)}"
    end

    def print_ref_clafer(ref_clafer)
      "#{ref_clafer.ref_name} -> #{ref_clafer.clafer_name} #{print_card(ref_clafer.card)}"
    end

    def print_card(card)
      map = {[1, 1]=>"",
             [0, 1] => "?",
             [1, "*"] => "+",
             [0, "*"] => "*" }
      out = map[[card.min, card.max]]
      out = "#{card.min}..#{card.max}" unless out != nil
      out
      #if card.min == 1 && card.max  == 1
      #  ""
      #elsif card.min == 0 && card.max = 1
      #  "?"
      #elsif card.min == 1 && card.max =="*"
      #  "+"
      #elsif card.min == 0 && card.max == "*"
      #  "*"
      #else
      #  "#{card.min}..#{card.max}"
      #end
    end

    def print_gcard(gcard)
      map = {[0,"*"]=>"",
             [1, 1] => "xor",
             [1, "*"] => "or",
             [0, 1] => "mux" }
      #[0, "*"] => "opt" }
      out = map[[gcard.min, gcard.max]]
      out = "#{gcard.min}-#{gcard.max}" unless out != nil
      out << " " unless out.empty?
      out
    end
  end

end
