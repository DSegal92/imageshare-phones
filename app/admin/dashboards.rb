ActiveAdmin::Dashboards.build do  
  section "Recent Calls", :priority => 2 do
    table_for Call.order('id desc').limit(10).each do
      column("Caller ID") {|call| link_to(call.caller_ID, '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID) } 
      column("Answered By")  {|call| Phone.find_by_id(call.answered).identity  } 
    end
  end

  section "Currently Active Groups" do
    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    groups = Group.find_all_by_enable(true).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime}.sort_by{|x| x.extension}
    table_for groups do
      column(:identity)
      column(:extension)
      column(:alias)
      column "Start Time " do |group|
        group.formatTime(group.start)
      end
      column "End Time" do |group|
        group.formatTime(group.endT)
      end
    end
  
    groups = Group.find_all_by_enable(true)
    phones = Phone.find(:all)
    table :class => "center" do
      thead do
        th
        groups.each do |group|
          th group.identity
        end
      end
      tbody do
        phones.each do |phone|
          tr
            unless phone.number == '0000000000'
              td phone.identity
            end
            groups.each do |group|             
              if group.phones.exists?(phone.id) && group.enable && phone.number != '0000000000'
                td "\u2714"
              elsif !group.phones.exists?(phone.id) && group.enable && phone.number != '0000000000'
                td "\u2718"
              end                           
            end
        end
      end
    end 
  end

  section "Next Called" do
    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    table do       
       groups = Group.find_all_by_enable(true).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime}.sort_by{|x| x.extension}.each do |group|
      thead do 
        th group.identity
      end
      tbody do
        count = group.counter 
        if group.phones[count].nil?
          group.counter = 0
          count = group.counter
        end
        td group.phones[count].identity
      end
      end
    end  
    end
end
