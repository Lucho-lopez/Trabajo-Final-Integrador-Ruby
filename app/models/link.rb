# app/models/link.rb
class Link < ApplicationRecord
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
        access_count == 0
      else
        false
      end
    end
    
    def private?
      link_type == 'private'
    end

    def visit_link(password = nil)
      return unless access_link(password)
  
      update_access_count
      true
    end
  
    private
  
    def update_access_count
      update(access_count: access_count + 1)
    end
  end
  