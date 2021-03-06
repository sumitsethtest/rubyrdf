module RubyRDF
  # An RDF plain literal.
  class PlainLiteral
    attr_reader :lexical_form
    attr_reader :language_tag

    # Constructs a new PlainLiteral using +lexical_form+ and
    # +language_tag+.  +language_tag+ is normalized to lower case.
    def initialize(lexical_form, language_tag = nil)
      @lexical_form = lexical_form.to_str
      @lexical_form = if @lexical_form.respond_to?(:utf8nfc)
                        @lexical_form.utf8nfc.to_str
                      else
                        @lexical_form.mb_chars.normalize(:c).to_str
                      end

      @language_tag = language_tag && language_tag.to_s.downcase
    end

    def ==(o) #:nodoc:
      @lexical_form == o.lexical_form &&
        @language_tag == o.language_tag
    rescue NoMethodError
      false
    end
    alias_method(:eql?, :==)

    def hash #:nodoc:
      [-584159468, @lexical_form, @language_tag].hash
    end

    # Returns self
    def to_literal
      self
    end

    # Returns the NTriples serialization of this node.
    def to_ntriples
      %Q("#{NTriples.escape(@lexical_form)}") + (@language_tag ? "@#{@language_tag}" : "")
    end
    alias_method :to_s, :to_ntriples
    alias_method :inspect, :to_ntriples
  end
end
