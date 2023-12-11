module LinkAccess
    extend ActiveSupport::Concern

    def access_link
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
end