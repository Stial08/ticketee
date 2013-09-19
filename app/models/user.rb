class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :token_authenticatable, :omniauthable

  has_many :projects

  def self.find_or_create_for_twitter(response)
    data = response['extra']['raw_info']
    if user = User.find_by_twitter_id(data["id"]) 
      user
    else # Create a user with a stub password.
      user = User.new(:email => "twitter+#{data["id"]}@example.com", :password => Devise.friendly_token[0,20])
      user.twitter_id = data["id"]
      user.twitter_screen_name = data["screen_name"]
      user.twitter_display_name = data["display_name"]
      user.password_confirmation = user.password
      user.save!
    end
  end

  def self.find_or_create_for_github(response)
    data = response['extra']['raw_info']
    if user = User.find_by_github_id(data["id"])
      user
    else # Create a user with a stub password.
      user = User.new(:email => data["email"],
                      :password => Devise.friendly_token[0,20])
      user.github_id = data["id"]
      user.github_user_name = data["login"]
      user.github_display_name = data["name"]
      user.password_confirmation = user.password
      user.save!
    end
  end

  def self.reset_request_count!
    update_all("request_count = 0", "request_count > 0")
  end
end


