class Link < ApplicationRecord
  belongs_to :user
  has_many :visit_infos, dependent: :destroy
  
  include UniqueToken
  include LinkAccess
  include LinkValidations

  enum link_type: {
    public_link: 0,
    private_link: 1,
    ephemeral_link: 2,
    temporal_link: 3
  }

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
  def self.find_by_unique_token(token)
    find_by(unique_token: token)
  end

  def create_visit_info(ip_address, visited_at)
    visit_infos.create(ip_address: ip_address, visited_at: visited_at)
  end
end