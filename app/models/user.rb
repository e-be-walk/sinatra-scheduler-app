class User < ActiveRecord::Base
  has_secure_password
  has_many :appointments

  def slug
    username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
