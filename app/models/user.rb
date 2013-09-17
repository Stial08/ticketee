class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable,
    :token_authenticatable, :omniauthable

  has_many :projects

  def self.find_or_create_for_twitter(response)
    data = response['extra']['user_hash']
    if user = User.find_by_twitter_id(data["id"]) 
      user
    else # Create a user with a stub password.
      user = User.new(:email => "twitter+#{data["id"]}@example.com",
                      :password => Devise.friendly_token[0,20])
                      user.twitter_id = data["id"]
                      user.twitter_screen_name = data["screen_name"]
                      user.twitter_display_name = data["display_name"]
                      user.confirm!
                      user
    end
  end

  def display_name
    if twitter_id
      "#{twitter_display_name} (@#{twitter_screen_name})"
    else
      email
    end
  end

  def self.reset_request_count!
    update_all("request_count = 0", "request_count > 0")
  end
end


