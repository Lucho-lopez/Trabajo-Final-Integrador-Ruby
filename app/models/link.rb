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


  def self.find_by_unique_token(token)
    find_by(unique_token: token)
  end

  def create_visit_info(ip_address, visited_at)
    visit_infos.create(ip_address: ip_address, visited_at: visited_at)
  end
end