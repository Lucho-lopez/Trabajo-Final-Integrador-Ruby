# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(username:"sinlinks",email:"sinlinks@sinlinks.com", password:"sinlinks")

@user = User.create(username:"conlinks",email:"conlinks@conlinks.com", password:"conlinks")
11.times do |time|
    i = time + 1
    token = "8ce84" + i.to_s
    Link.create(link_name: "nombre_link", 
                url: "https://www.google.com/", 
                link_type: "public_link", 
                expires_at: nil, 
                link_password: nil,
                unique_token: token,
                user_id: @user_id)
end

Link.create(link_name: "link privado", 
            url: "https://www.google.com/", 
            link_type: "private_link", 
            expires_at: nil, 
            link_password: "test",
            unique_token: "28ce84",
            user_id: @user_id)

Link.create(link_name: "link efimero", 
            url: "https://www.google.com/", 
            link_type: "ephemeral_link", 
            expires_at: nil, 
            link_password: nil,
            unique_token: "38ce84",
            user_id: @user_id)

Link.new(link_name: "link temporal vencido", 
            url: "https://www.google.com/", 
            link_type: "temporal_link", 
            expires_at: "2023-12-01 11:01:00", 
            link_password: nil,
            unique_token: "48ce84",
            user_id: @user_id).save(validate: false)

Link.create(link_name: "link temporal valido", 
            url: "https://www.google.com/", 
            link_type: "temporal_link", 
            expires_at: "2024-12-01 11:01:00", 
            link_password: nil,
            unique_token: "58ce84",
            user_id: @user_id)         

            
VisitInfo.create(ip_address: "192.168.0.1",
                 visited_at: "2023-12-11 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-10 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-09 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-08 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-07 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-06 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "127.0.0.1",
                 visited_at: "2023-12-05 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "10.0.0.1",
                 visited_at: "2023-12-10 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "10.0.0.1",
                 visited_at: "2023-12-10 14:19:11.107360",
                 link_id: 12)
VisitInfo.create(ip_address: "10.0.0.1",
                 visited_at: "2023-12-10 14:19:11.107360",
                 link_id: 12)
