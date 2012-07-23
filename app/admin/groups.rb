ActiveAdmin.register Group do
   form do |f|
    f.inputs do
      f.input :identity, :label => "External Name (Identity)"
      f.input :alias, :label => "Internal Name (Alias)"
      f.input :extension
      f.input :startTime, :label => "Start Time (0-23)", :input_html => {:value => 0}
      f.input :endTime, :label => "End Time (0-23)", :input_html => {:value => 23}
      f.input :counter, :input_html => {:value => 0}
      f.input :phones, :member_label => :identity, :as => :check_boxes
      f.input :enable
      
    end
    f.buttons
  end

  index do
    column :id
    column :identity
    column :alias
    column :extension
    column :startTime
    column :endTime
    column "Enabled" do |group|
      group.enable
    end
    default_actions
  end  

  show do |ad|
  attributes_table do
  h2 b group.identity
  h3 b group.alias
  h3 'Phones'
  table do
  	thead do
  		th 'Identity'
  		th 'Number'
  		th 'Extension'
  	end
  	tbody do
  	group.phones.each do |phone|
  		tr
  			td phone.identity
  			td phone.number
  			td phone.extension
  		end
  	end
  end
  	end
  end
end
