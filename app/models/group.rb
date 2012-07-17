class Group < ActiveRecord::Base
  attr_accessible :email, :extension, :identity, :phone_id, :group, :phone_ids, :startTime, :endTime, :counter
  validates_presence_of :identity, :extension
  
  has_and_belongs_to_many :phones
 end
