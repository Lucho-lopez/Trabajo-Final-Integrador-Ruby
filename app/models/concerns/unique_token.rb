module UniqueToken
    extend ActiveSupport::Concern

    included do
        before_create :generate_unique_token
    end

    def generate_unique_token
        new_token = SecureRandom.hex(3)

        while self.class.exists?(unique_token: new_token)
        new_token = SecureRandom.hex(3)
        end

        self.unique_token = new_token
    end
end