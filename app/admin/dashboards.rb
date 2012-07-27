ActiveAdmin::Dashboards.build do

  
  section "Recent Calls", :priority => 2 do
    table_for Call.order('id desc').limit(10).each do
      column("Caller ID") {|call| link_to(call.caller_ID, '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID) } 
      column("Answered By")  {|call| call.answered  } 
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
            td phone.identity
            groups.each do |group|             
              if group.phones.exists?(phone.id) && group.enable
                td "\u2714"
              elsif !group.phones.exists?(phone.id) && group.enable
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


  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
