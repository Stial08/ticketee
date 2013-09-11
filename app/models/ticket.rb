class Ticket < ActiveRecord::Base

 
  attr_accessor :tag_names
  #attr_accessible :description, :title, :assets_attributes, :tag_names
  before_create :associate_tags

  belongs_to :project
  belongs_to :user
  belongs_to :state
  has_many :assets
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :assets

  validates :title, presence: true
  validates :description, presence: true,
                          length: { minimum: 10 }

  private
  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by_name(name)
      end
    end
  end
end
