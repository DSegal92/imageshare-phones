class Call < ActiveRecord::Base
  attr_accessible :answered, :caller_ID, :location, :notes, :origin, :target, :was_connected, :menuTime, :timesCalled, :site

end
