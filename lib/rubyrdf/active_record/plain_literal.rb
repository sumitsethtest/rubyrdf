if defined?(ActiveRecord)
  require 'rubyrdf/active_record'

  module RubyRDF
    class ActiveRecord
      class PlainLiteral < ::ActiveRecord::Base
        has_many :subject_statements, :as => :subject, :class_name => "RubyRDF::ActiveRecord::Statement"
        has_many :predicate_statements, :as => :predicate, :class_name => "RubyRDF::ActiveRecord::Statement"
        has_many :object_statements, :as => :object, :class_name => "RubyRDF::ActiveRecord::Statement"

        def to_rdf(bnodes)
          ::RubyRDF::PlainLiteral.new(lexical_form, language_tag)
        end
      end
    end
  end
end
