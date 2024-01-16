class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  HUMANIZED_ATTRIBUTES = {
        link_name: "Nombre del link",
        link_type: "Tipo de link",
        expires_at: "Expira",
        link_password: "Contraseña",
        unique_token: "Token único"
    }.freeze

    def self.human_attribute_name(attr, options = {})
        HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end
end
