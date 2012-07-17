class Phone < ActiveRecord::Base
  attr_accessible :extension, :identity, :number, :group_ids, :enable
  validates_presence_of :extension, :identity, :number
  
  has_and_belongs_to_many :groups
end
