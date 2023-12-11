module LinkAccess
    extend ActiveSupport::Concern

    def access_link
        case link_type
        when 'public_link'
            true
        when 'temporal_link'
            expires_at > Time.now
        when 'ephemeral_link'
            visit_infos.empty?
        else
            false
        end
    end

    def public_link?
        link_type == 'public_link'
      end
      
      def private_link?
        link_type == 'private_link'
      end
      
      def ephemeral_link?
        link_type == 'ephemeral_link'
      end
      
      def temporal_link?
        link_type == 'temporal_link'
      end
end