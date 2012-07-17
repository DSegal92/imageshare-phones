ActiveAdmin.register Group do
   form do |f|
    f.inputs do
      f.input :identity
      f.input :extension
      f.input :email
      f.input :startTime, :label => "Start Time (1-24)"
      f.input :endTime, :label => "End Time (1-24)"
      f.input :counter
      f.input :phones, :member_label => :identity, :as => :check_boxes
      
    end
    f.buttons
  end

  index do
    column :id
    column :identity
    column :extension
    column :email
    column :startTime
    column :endTime
    default_actions
  end  

  show do |ad|
  attributes_table do
  h2 b group.identity
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
