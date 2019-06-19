class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  def slug
    self.username.downcase.gsub(" ", "_")
  end
end
