ActiveAdmin::Dashboards.build do
  time = Time.now.hour  
  section "Recent Calls", :priority => 2 do
    table_for Call.order('id desc').limit(10).each do
      column("Caller ID") {|call| link_to(call.caller_ID, '/admin/calls?&q%5Bcaller_ID_contains%5D=' + call.caller_ID) } 
      column("Answered By")  {|call| call.answered  } 
    end
  end
  section "Currently Active Groups" do
    groups = Group.find_all_by_enable(true).select{|g| g.startTime <= time && g.endTime >= time}.sort_by{|x| x.extension}
    table_for groups do
      column(:identity)
      column(:extension)
      column(:alias)
      column(:startTime)
      column(:endTime)
      column "Phones" do |group|
        group.phones.collect! { |x| x.number + " - " + x.identity}.to_a
      end
    end
  end

  section "Next Called" do
    table do       
       groups = Group.find_all_by_enable(true).select{|g| g.startTime <= time && g.endTime >= time}.sort_by{|x| x.extension}.each do |group|
      thead do 
        th group.identity
      end
      tbody do
        count = group.counter 
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
