class User < ActiveRecord::Base
  has_secure_password
  has_many :appointments
  has_many :todos
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true 

  def slug
    username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end
