ActiveAdmin.register Phone do
	index do
		column :id
		column :identity
		column :number
		column :extension
		column "Enabled" do |phone|
			phone.enable
		end
		default_actions
	end

	form do |f|
		f.inputs do
			f.input :identity
			f.input :extension
			f.input :number
			f.input :groups , :as => :check_boxes, :member_label => :identity
			f.input :enable
	
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
