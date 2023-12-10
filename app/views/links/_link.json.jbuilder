json.extract! link, :id, :link_name, :url, :link_type, :expires_at, :link_password, :unique_token, :access_count, :created_at, :updated_at
json.url link_url(link, format: :json)
