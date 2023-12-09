json.extract! visit_info, :id, :ip_address, :visited_at, :created_at, :updated_at
json.url visit_info_url(visit_info, format: :json)
