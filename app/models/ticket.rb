class Ticket < ActiveRecord::Base
#before_action :require_signin!, except: [:show, :index]
  mount_uploader :asset, AssetUploader
  belongs_to :project
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }
  
end
