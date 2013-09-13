class User < ActiveRecord::Base
  has_secure_password
  has_many :projects
  def self.reset_request_count!
    update_all("request_count = 0", "request_count > 0")
  end
end


