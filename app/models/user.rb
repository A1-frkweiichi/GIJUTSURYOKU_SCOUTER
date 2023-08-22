class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    user = find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
    user ||= create(provider: auth_hash[:provider], uid: auth_hash[:uid], name: auth_hash[:info][:name])
    user
  end
end
