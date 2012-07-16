ActiveAdmin.register Call do
  index do
  	column :id
  	column :target
  	column :caller_ID
  	column "Length (s)" do |call|
  		call.length
  	end
  	column :times_called
  	column :was_connected  	
  	column :location
  	column :notes
  	column :created_at
  	column :updated_at
  	default_actions
  end
end
