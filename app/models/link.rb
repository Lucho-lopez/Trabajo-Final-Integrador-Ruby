class Link < ApplicationRecord
  include UniqueToken
  include LinkAccess
  include LinkValidations

  belongs_to :user
  has_many :visit_infos, dependent: :destroy

  def self.find_by_unique_token(token)
    find_by(unique_token: token)
  end

  def create_visit_info(ip_address, visited_at)
    visit_infos.create(ip_address: ip_address, visited_at: visited_at)
  end
end