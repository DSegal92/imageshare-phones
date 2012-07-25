ActiveAdmin.register Phone do
	index do
		column :id
		column :identity
		column :number, :as => :phone
		column :extension
		column :email
		default_actions
	end

	form do |f|
		f.inputs do
			f.input :identity
			f.input :extension
			f.input :number
			f.input :email
			f.input :groups , :as => :check_boxes, :member_label => :identity
		end
		f.buttons
	end 

	show do |ad|
		attributes_table do
		table do
			tr
				th 'Identity'
				td phone.identity
			tr
				th 'Number'
				td phone.number
			tr
				th 'Extension'
				td phone.extension	
			end
				h4 'Groups:'
				phone.groups.each do |group|
					ul "- " + group.identity
				end


		
		end
	end 


end
