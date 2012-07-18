ActiveAdmin.register Call do
  index do
  	column :id
  	column "Target", :sortable => :target do |call|
      #'#' = 'http://localhost:3000/admin/calls?&q%5Btarget_contains%5D=' + call.target
      link_to call.target, '#'
    end
    column "Answered By", :sortable => :answered do |call|
      #'#' = 'http://localhost:3000/admin/calls?&q%5Banswered_contains%5D=' + call.answered
      link_to call.answered, '#'
    end 
  	column "Caller ID", :sortable => :caller_ID do |call|
      #'#' = 'http://localhost:3000/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID
      link_to call.caller_ID, '#'
    end
    column "Times Called" do |call|
      Call.find_all_by_caller_ID(call.caller_ID).size
    end
  	column "Length (s)" do |call|
  		call.menuLength
  	end 
  	column "Location", :sortable => :location do |call|
      #'#' = 'http://localhost:3000/admin/calls?&q%5Blocation_contains%5D=' + call.location
      link_to call.location, '#'
    end
  	column "Notes" do |call|
      call.notes.truncate(10)
    end
    column :was_connected   
  	column :created_at
  	column :updated_at
  	default_actions
  end

 form do |f|
   f.inputs do
     f.input :target
     f.input :answered, :label => "Answered By"
     f.input :caller_ID, :label => "Caller ID"
     f.input :menuLength, :label => "Time Spent in Menu (s)"
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
          td call.menuLength
        tr
          th 'Location'
          td call.location
          th 'Was Connected?'
          if call.was_connected?
            td "True"
          else
            td "False"
          end
        tr
          th 'Times Called'
          td Call.find_all_by_caller_ID(call.caller_ID).size

      end  
      table do
        tr
          th 'Notes'
          td call.notes
      end        
    end
  end 

end
