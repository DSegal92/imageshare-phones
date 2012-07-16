ActiveAdmin.register Group do
   form do |f|
    f.inputs do
      f.input :identity
      f.input :extension
      f.input :email
      f.input :phones, :member_label => :identity, :as => :check_boxes
    end
    f.buttons
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
