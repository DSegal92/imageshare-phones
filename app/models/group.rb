class Group < ActiveRecord::Base
  attr_accessible :email, :extension, :identity, :phone_id, :group, :phone_ids, :startTime, :endTime, :counter, :enable
  validates_presence_of :identity, :extension
  
  has_and_belongs_to_many :phones

  def incrCounter(group)
    group.counter += 1
      if group.counter >= group.phones.size - 1
        group.counter = 0
      end
     group.save
     puts "Incremented counter for group " + group
  end 
 end