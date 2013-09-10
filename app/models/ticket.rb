class Ticket < ActiveRecord::Base
#before_action :require_signin!, except: [:show, :index]
  belongs_to :project
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }
  mount_uploader :asset, AssetUploader
end
