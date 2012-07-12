class Call < ActiveRecord::Base
  attr_accessible :answered_id, :caller_ID, :length, :location, :notes, :origin, :target, :times_called, :was_connected
end
