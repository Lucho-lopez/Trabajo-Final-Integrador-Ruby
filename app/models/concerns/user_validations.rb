module UserValidations
    extend ActiveSupport::Concern

    included do
        validates :username, presence: true, uniqueness: { case_sensitive: false }
        validates_format_of :username, with: /\A[a-zA-Z0-9_\.]{4,}\z/, message: 'debe tener al menos 4 caracteres y no tener caracteres especiales'
    end

    HUMANIZED_ATTRIBUTES = {
        email: "Correo electrónico",
        password_confirmation: "Confirmación de contraseña",
        password: "Contraseña",
        username: "Nombre de usuario"
    }.freeze

    def self.human_attribute_name(attr, options = {})
        HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end
end