class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all

 #def searcher 
    #label :tag, :from => :tags, :field => :name
 #end
end
