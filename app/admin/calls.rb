ActiveAdmin.register Call do
  #attr_accessible :answered_id, :caller_ID, :length, :location, :notes, :origin, :target, :times_called, :was_connected
  index do
  	column :id
  	column :target
  	column :origin
  	column "Length (s)" do |call|
  		call.length
  	end
  	column :times_called
  	column :was_connected
  	column :caller_ID
  	column :location
  	column :notes
  	column :created_at
  	column :updated_at
  	default_actions
  end
end
