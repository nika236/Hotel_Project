module Hotels; end
Rails.autoloaders.main.push_dir("#{Rails.root}/app/services", namespace: Hotels)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/services/hotels", namespace: Hotels)

module Rooms;end

Rails.autoloaders.main.push_dir("#{Rails.root}/app/services", namespace: Rooms)
Rails.autoloaders.main.push_dir("#{Rails.root}/app/services/rooms", namespace: Rooms)