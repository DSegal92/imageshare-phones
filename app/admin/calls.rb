Time.zone = 'Eastern Time (US & Canada)'  

ActiveAdmin.register Call do
  index do
    column :id
  	column "Target", :sortable => :target do |call|
      unless call.target.nil?
        @searchURL = '/admin/calls?&q%5Btarget_contains%5D=' + call.target
        link_to Group.find_by_id(call.target).identity, @searchURL
      end
    end
    column "Answered By", :sortable => :answered do |call|
      unless call.answered.nil?
        @searchURL = '/admin/calls?&q%5Banswered_contains%5D=' + call.answered
        unless call.answered == "Hang Up"
          link_to Phone.find_by_id(call.answered).identity, @searchURL
        end
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
    column "Call Length" do |call|
      call.getTime(call.menuTime)
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
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
   f.inputs do
     f.input :target, :as => :select, :collection => Group.find(:all), :member_label => :identity
     f.input :answered, :as => :select, :collection => Phone.find(:all), :member_label => :identity, :label => "Answered By"
    if call.caller_ID.nil?
      f.input :caller_ID, :label => "Caller ID"
    else
     f.input :caller_ID, :label => link_to("Caller ID", '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID, :target => '_blank')
   end
     f.input :menuTime, :label => "Call Length (s)"
     f.input :site, :as => :select, :collection => call.getSites
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
      th 'Call Length'
      td call.getTime(call.menuTime)
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
