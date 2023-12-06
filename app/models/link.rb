# app/models/link.rb
class Link < ApplicationRecord
    
    belongs_to :user
    validates :url, presence: true
  
    before_create :generate_unique_token

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
        #ver cuantos visitantes tiene
        true
      else
        false
      end
    end
    
    def private?
      link_type == 'private'
    end
  
  end
  