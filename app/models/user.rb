class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates_format_of :username, with: /\A[a-zA-Z0-9_\.]{4,}\z/, message: 'debe tener al menos 4 caracteres y no tener caracteres especiales'

    
    has_many :links, dependent: :destroy
    HUMANIZED_ATTRIBUTES = {
      email: "Correo electrónico",
      password_confirmation: "Confirmación de contraseña",
      password: "Contraseña",
      username: "Nombre de usuario"
    }
    def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end
    
    attr_writer :login
    
    def login
      @login || self.username || self.email
    end

    def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if (login = conditions.delete(:login))
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        if conditions[:username].nil?
          where(conditions).first
        else
          where(username: conditions[:username]).first
        end
      end
    end
  end
  