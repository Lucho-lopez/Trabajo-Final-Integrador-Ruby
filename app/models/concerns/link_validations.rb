module LinkValidations
    extend ActiveSupport::Concern

    included do
        validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "es inválido, un ejemplo válido es https://rubyonrails.org" }
        validates :link_password, presence: true, if: :private_link?
        validates :expires_at, presence: true, if: :temporal_link?
        validate :url_not_same_as_current_domain
        validate :expiration_date_cannot_be_in_the_past, if: :temporal_link?
        validates_uniqueness_of :unique_token
    end

    

    def url_not_same_as_current_domain
        return unless url.present?

        current_domain = 'chq.to'

        if URI.parse(url).host == current_domain || URI.parse(url).host == "127.0.0.1"
        errors.add(:url, "no puede ser igual al dominio actual")
        end
    end

    def expiration_date_cannot_be_in_the_past
        if expires_at.present? && expires_at < Date.today
          errors.add(:expires_at, "no puede ser anterior a la fecha actual")
        end
      end
end