Time.zone = 'Eastern Time (US & Canada)'  

ActiveAdmin.register Call do
  scope :connected_calls
  scope :all
  scope :hang_ups

  index do
    @preface = '/admin/calls?&q%5B'
    column :id
  	column "Target", :sortable => :target do |call|
      unless call.target.nil?
        @searchURL = @preface + 'target_contains%5D=' + call.target
        link_to Group.find_by_id(call.target).identity, @searchURL
      end
    end
    column "Answered By", :sortable => :answered do |call|
      unless call.answered.nil?
        @searchURL = @preface + 'answered_contains%5D=' + call.answered
        link_to Phone.find_by_id(call.answered).identity, @searchURL
      end
    end 
    column "Caller ID", :sortable => :caller_ID do |call|
      unless call.caller_ID.nil?
        @searchURL = @preface + 'caller_ID_contains%5D=' + call.caller_ID
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
        @searchURL = @preface + 'location_contains%5D=' + call.site
        link_to call.site, @searchURL
      end
    end
    column :location
    column "Notes" do |call|
      unless call.notes.nil?
        call.notes.truncate(10)
      end
    end
    column "Status" do |call|
      if call.answered == Phone.find_by_identity("In Progress").id.to_s
        status_tag ("In Progress"), (:warning)
      else
        status_tag (call.was_connected ? "Answered" : "Hung Up"), (call.was_connected ? :ok : :error)
      end
    end  
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
   f.inputs do
      unless params[:initialCall] == 'true'
        f.input :target, :as => :select, :collection => Group.find(:all).sort!{|a,b| a.identity <=> b.identity }, :member_label => :identity
        f.input :answered, :as => :select, :collection => Phone.find(:all).sort!{|a,b| a.identity <=> b.identity }, :member_label => :identity, :label => "Answered By"    
        if call.caller_ID.nil?
         f.input :caller_ID, :label => "Caller ID"
        else
         f.input :caller_ID, :label => link_to("Caller ID", '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID, :target => '_blank'), :input_html => { :readonly => true }
        end
        f.input :menuTime, :label => "Call Length (s)", :input_html => { :readonly => true }
        f.input :was_connected
      end
      unless call.caller_ID.nil?
        f.input :caller_ID, :label => link_to("Caller ID", '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID, :target => '_blank'), :input_html => { :readonly => true }
      end
        f.input :site, :as => :select, :collection => call.getSites
        f.input :location 
        f.input :notes
       
    
   end
   f.buttons

 end



 show do |ad|
  attributes_table do
    table do
      tr
      th 'Target'
      td Group.find_by_id(call.target).identity
      th 'Answered By'
      td Phone.find_by_id(call.answered).identity
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
