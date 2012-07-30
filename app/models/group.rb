class Group < ActiveRecord::Base
  attr_accessible :email, :extension, :identity, :phone_id, :group, :phone_ids, :startTime, :endTime, :counter, :enable, :alias, :start, :endT, :callback
  validates_presence_of :identity, :extension
  
  has_and_belongs_to_many :phones

  def incrCounter(group)
    group.counter += 1
      if group.counter >= group.phones.size
        group.counter = 0
      end
     group.save
     puts "Incremented counter for group " + group.counter.to_s
  end 

  def formatTime(t)
    if t.hour < 10 && t.min < 10
      time = '0' + t.hour.to_s + ':0' + t.min.to_s
    elsif t.hour < 10 && t.min > 10
      time = '0' + t.hour.to_s + ':' + t.min.to_s
    elsif t.hour > 10 && t.min < 10
      time = t.hour.to_s + ':0' + t.min.to_s
    elsif t.hour > 10 && t.min > 10
      time = t.hour.to_s + ':' + t.min.to_s
    end
  end
 end