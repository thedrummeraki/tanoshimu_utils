module TanoshimuUtils
  module Concerns
    module HasTranslatableField
      extend ActiveSupport::Concern

      class_methods do
        def has_translatable_field(name, foreign_key: :model_id)
          set_translatable_field = :"#{name}="
          get_translatable_field = :"#{name}"
          record_field = :"#{name}_record"
          record_class = Object.const_get(name.capitalize)

          send(:define_method, get_translatable_field) do
            instance_variable_get("@#{name}") || 
              instance_variable_set("@#{name}", send(record_field)&.value)
          end

          send(:define_method, set_translatable_field) do |new_record_field|
            return unless new_record_field.kind_of?(record_class)

            new_record_field.used_by_model = record_class.table_name
            new_record_field.send(:"#{foreign_key}=", self.id)
            self.send(:"#{record_field}=", new_record_field)
          end
          
          has_one(
            record_field,
            class_name: record_class.to_s,
            foreign_key: foreign_key,
          )
        end
      end
    end
  end
end
