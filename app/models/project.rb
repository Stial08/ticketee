class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all
  belongs_to :user
 #def searcher 
    #label :tag, :from => :tags, :field => :name
 #end
  def last_ticket
    tickets.last
  end
end
