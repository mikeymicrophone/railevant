############################################################

#
# acts_as_bitfield.rb
#
# Version: 0.2
#
# (C) 2005 Gabriel Gironda
# 
# Usage:
#
# acts_as_bitfield :some_column, :fields => [:option_one, :option_two]
#
# 
# TODO: Write actual documentation for all the people who looked
# here disappointed to find little documentation
# 
# See helicoid.net or gironda.org for latest versions.
#
############################################################


require 'active_record'

module Helicoid
  module Acts #:nodoc:
    module Bitfield #:nodoc:

      def self.append_features(base)
        super
        base.extend(ClassMethods)
      end

      # declare the class level helper methods
      # which will load the relevant instance methods defined below when invoked
       module ClassMethods
        def acts_as_bitfield(column, configuration)
          unless respond_to? :bitfield_attrs
            class_eval { cattr_accessor :bitfield_attrs, :bitfield_columns } 
            self.bitfield_columns, self.bitfield_attrs = {}, {}
          end
          attrs_and_values = create_field_values_hash(column, configuration[:fields])
          self.bitfield_columns[column] = attrs_and_values
          attrs_and_values.each { |k,v| create_field_accessors(column, k, v) }
          self.bitfield_attrs.merge!(attrs_and_values)

          class_eval { extend Helicoid::Acts::Bitfield::SingletonMethods }
        end
        
        private
        # Determines the value of each field in the bitfield.
        def create_field_values_hash(column, fields)
          attrs = {}
          fields.inject(1) do |n, f|
            attrs[f] = [n, column]
            n * 2
          end
          return attrs
        end
        
        # Creates instance methods to check for and set field values
        def create_field_accessors(column, field, value)
          # define the method to check if the field is true or false
          define_method(field) { (value.first & (self[column] || 0) != 0) }

          # define the method to set the field value
          define_method(:"#{field.to_s}=") do |v|
            if [true, '1', 1, 't'].include? v
              self[column] = (self[column] || 0) | value.first
            elsif [false, '0', 0, 'f'].include? v
              self[column] = (self[column] || 0) &~ value.first
            end
          end
          alias_method :"#{field.to_s}?", field
        end        
      end
      
      module SingletonMethods
        # we need our own all_attributes_exists in order to hack the dynamic Active Record finders
        def all_attributes_exists?(attribute_names)
          attrs = column_methods_hash.merge(self.bitfield_attrs)
          attribute_names.all? { |name| attrs.include?(name.to_sym) }
        end

        # also requires a new construct_conditions_from_arguments
        def construct_conditions_from_arguments(attribute_names, arguments)
          conditions = []
          if attribute_names.find { |a| self.bitfield_attrs[a.to_sym] }
            attribute_names, arguments, bitwise_conditions = construct_bitwise_conditions(attribute_names, arguments)
            conditions << bitwise_conditions
          end
          attribute_names.each_with_index { |name, idx| conditions << "#{table_name}.#{name} #{attribute_condition(arguments[idx])} " }
          [ conditions.join(" AND "), *arguments[0...attribute_names.length] ]
        end

        # checks the given list if attribute names for any bitfield attributes and constructs
        # the proper sql.
        def construct_bitwise_conditions(attribute_names, arguments)
          attr_names, args = attribute_names.dup, arguments.dup # so we don't delete the originals
          bitfield_values_and_columns, attrs_to_delete = [], []    
          attr_names.each_with_index do |name, idx|
            if field_value = self.bitfield_attrs[name.to_sym]
              attrs_to_delete << idx
              bitfield_values_and_columns << [field_value, args[idx]]
            end
          end
          attrs_to_delete.sort.reverse.each { |i| attr_names.delete_at(i); args.delete_at(i) }
          return attr_names, args, bitwise_condition_sql(bitfield_values_and_columns)
        end
        
        # builds the sql fragment for bitfield searches
        def bitwise_condition_sql(values)
          values.sort! { |x,y| x.first.first <=> y.first.first }.reverse!
          sql_pieces = values.collect do |v|
            "(#{table_name}.#{v.first.last} & #{v.first.first} " + (v.last ? "!= 0" : "= 0") + ")"
          end
          sql_pieces.join(" AND ")
        end
        
      end
    end
  end
end

ActiveRecord::Base.class_eval { include Helicoid::Acts::Bitfield }
