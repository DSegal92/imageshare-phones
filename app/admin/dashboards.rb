ActiveAdmin::Dashboards.build do

  # Displays 10 more recent calls, with CallerIDs (linked to calls)
  section "Recent Calls", :priority => 2 do
    table_for Call.order('id desc').limit(10).each do
      column("Caller ID") {|call| link_to(call.caller_ID, '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID) } 
      column("Answered By")  {|call| Phone.find_by_id(call.answered).identity  } 
    end
  end

  # Displays currently active groups based on time and day of week -- displays who is in each group. 
  section "Currently Active Groups" do
    day = Time.now.wday
    # compTime converts current time to decimal to compare to group time. Temporary hack until Time objects aren't selected as datetimes.
    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    groups = Group.find_all_by_enable(true).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime && g.days.exists?(:value => day)}.sort_by{|x| x.extension}
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
    # Grid of active groups v. phones
    groups = Group.find_all_by_enable(true)
    phones = Phone.find(:all)
    table :class => "center" do
      thead do
        th
        groups.each do |group|
          if group.days.exists?(:value => day)
          th group.identity
        end
        end
      end
      tbody do
        phones.each do |phone|
          tr
            unless phone.number == '0000000000'
              td phone.identity
            end
            groups.each do |group|             
              if group.phones.exists?(phone.id) && group.enable && phone.number != '0000000000' && group.days.exists?(:value => day)
                td "\u2714"
              elsif !group.phones.exists?(phone.id) && group.enable && phone.number != '0000000000' && group.days.exists?(:value => day)
                td "\u2718"
              end                           
            end
        end
      end
    end 
  end

  # Heads up of who is 'on deck' for next call in each active category without affecting counter
  section "Next Called" do
    day = Time.now.wday
    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    table do       
       groups = Group.find_all_by_enable(true).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime && g.days.exists?(:value => day)}.sort_by{|x| x.extension}.each do |group|
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
