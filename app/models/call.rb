class Call < ActiveRecord::Base
  attr_accessible :answered, :caller_ID, :length, :location, :notes, :origin, :target, :was_connected, :menuLength
end
