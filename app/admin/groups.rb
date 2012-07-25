Time.zone = 'Eastern Time (US & Canada)'  

ActiveAdmin.register Group do
   form do |f|
    f.inputs do
      f.input :identity, :label => "External Name (Identity)"
      f.input :alias, :label => "Internal Name (Alias)"
      f.input :extension
      f.input :counter, :input_html => {:value => 0}
      f.input :phones, :member_label => :identity, :as => :check_boxes
      f.input :start, :as => :datetime, :ignore_date => true, :hint => "Insert arbitrary values for first 3 dropdowns- Date is Ignored"
      f.input :endT, :as => :datetime, :ignore_date => true, :hint => "Insert arbitrary values for first 3 dropdowns- Date is Ignored"
      f.input :enable
      
    end
    f.buttons
  end

  index do
    column :id
    column :identity
    column :alias
    column :extension
    column "Start Time " do |group|
      if group.start
        if group.start.min < 10
          group.start.hour.to_s + ":0" + group.start.min.to_s
        else
          group.start.hour.to_s + ":" + group.start.min.to_s
        end
      end
    end
    column "End Time" do |group|
      if group.endT
       if group.endT.min < 10
          group.endT.hour.to_s + ":0" + group.endT.min.to_s
        else
          group.endT.hour.to_s + ":" + group.endT.min.to_s
        end
      end
    end
    f.input :days, :as => :text
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
