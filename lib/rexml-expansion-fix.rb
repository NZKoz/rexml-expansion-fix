require 'rexml/document'
require 'rexml/entity'

module REXML
  class Entity < Child
		def unnormalized
      document.record_entity_expansion!
      v = value()
			return nil if v.nil?
      @unnormalized = Text::unnormalize(v, parent)
			@unnormalized
		end
  end
  class Document < Element
    @@entity_expansion_limit = 10_000
    def self.entity_expansion_limit= val
      @@entity_expansion_limit = val
    end
    
    def record_entity_expansion!
      @number_of_expansions ||= 0
      @number_of_expansions += 1
      if @number_of_expansions > @@entity_expansion_limit
        raise "Number of entity expansions exceeded, processing aborted."
      end
    end
  end
end

