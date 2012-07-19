ActiveAdmin.register Call do
  index do
  	column :id
  	column "Target", :sortable => :target do |call|
      unless call.target.nil?
        @searchURL = '/admin/calls?&q%5Btarget_contains%5D=' + call.target
        link_to call.target, @searchURL
      end
    end
    column "Answered By", :sortable => :answered do |call|
      unless call.answered.nil?
        @searchURL = '/admin/calls?&q%5Banswered_contains%5D=' + call.answered
        link_to call.answered, @searchURL
      end
    end 
  	column "Caller ID", :sortable => :caller_ID do |call|
      unless call.caller_ID.nil?
        @searchURL = '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID
        link_to call.caller_ID, @searchURL
      end
    end
    column "Times Called" do |call|
      unless call.caller_ID.nil?
        Call.find_all_by_caller_ID(call.caller_ID).size
      end
    end
  	column "Call Length (s)" do |call|
      unless call.menuTime.nil?
  		  call.menuTime.to_i / 60 + " min " + call.menuTime.to_i % 60 + " s"
      end
  	end 
  	column "Site", :sortable => :site do |call|
      unless call.site.nil?
        @searchURL = '/admin/calls?&q%5Blocation_contains%5D=' + call.site
        link_to call.site, @searchURL
      end
    end
    column :location
  	column "Notes" do |call|
      unless call.notes.nil?
        call.notes.truncate(10)
      end
    end
    column :was_connected
    column :session   
  	column :created_at
  	column :updated_at
  	default_actions
  end

 form do |f|
   f.inputs do
     f.input :target
     f.input :answered, :label => "Answered By"
     f.input :caller_ID, :label => "Caller ID"
     f.input :menuTime, :label => "Time Spent in Menu (s)"
     f.input :site, :as => :select, :collection => ["A", "B", "C", "D", "E"]
     f.input :location 
     f.input :notes
     f.input :was_connected
     
   end
   f.buttons
 end

  show do |ad|
    attributes_table do
      table do
        tr
          th 'Target'
          td call.target
          th 'Answered By'
          td call.answered
        tr
          th 'Caller ID'
          td call.caller_ID
          th 'Length In Menu (s)'
          td call.menuTime
        tr
          th 'Site'
          td call.site
          th 'Location'
          td call.location
        tr
          th 'Times Called'
          td Call.find_all_by_caller_ID(call.caller_ID).size
          th 'Was Connected?'
          if call.was_connected?
            td "True"
          else
            td "False"
          end

      end  
      table do
        tr
          th 'Notes'
          td call.notes
      end        
    end
  end 

end
