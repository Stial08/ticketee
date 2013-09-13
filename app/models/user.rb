class User < ActiveRecord::Base
  has_secure_password
  before_save :ensure_authentication_token
end


