# app/models/link.rb
class Link < ApplicationRecord
    
    belongs_to :user
    has_many :visit_infos, dependent: :destroy
    validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "es invalido, un ejemplo de una url valida es http://127.0.0.1:3000"} 
    validates :link_password, presence: true, if: -> { link_type == 'private' }
    validates :expires_at, presence: true, if: -> { link_type == 'temporal' }
    validate :url_not_same_as_current_domain 
    before_create :generate_unique_token

    
    HUMANIZED_ATTRIBUTES = {
      link_name: "Nombre del link",
      link_type: "Tipo de link",
      expires_at: "Expira",
      link_password: "Contraseña",
      unique_token: "Token único"
    }
    def self.human_attribute_name(attr, options = {})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end

    def generate_unique_token
      new_token = SecureRandom.hex(3) 

      while Link.exists?(unique_token: new_token)
        new_token = SecureRandom.hex(3) 
      end

      self.unique_token = new_token
    end
  
    def self.find_by_unique_token(token)
      find_by(unique_token: token)
    end

    def access_link()
      case link_type
      when 'regular'
        true
      when 'temporal'
        expires_at > Time.now
      when 'ephemeral'
        !visit_infos.present?
      else
        false
      end
    end
    
    def private?
      link_type == 'private'
    end

    def create_visit_info(ip_address, visited_at)
      visit_infos.create(ip_address: ip_address, visited_at: visited_at)
    end

    def url_not_same_as_current_domain
      return unless url.present?
  
      current_domain = 'chq.to'
  
      if URI.parse(url).host == current_domain
        errors.add(:url, "no puede ser igual al dominio actual")
      end
    end
    
  end
  