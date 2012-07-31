class CallsController < ApplicationController
  def index
  end

  def show
    group = Group.find_by_extension(params[:id])
    day = Time.now.wday
    if Call.where(:caller_ID => '6465582608').where(:target => group.id.to_s).where(:created_at => group.callback.days.ago..Time.now).where(:was_connected => true).exists?
      call = Call.where(:caller_ID => params[:caller_ID]).where(:target => group.identity).where(:created_at => group.callback.days.ago..Time.now).where(:was_connected => true).first()
      phone = Phone.find_by_identity(call.answered)
      render :json => {:name => call.target, :identity => call.answered, :number => phone.number, :callback => group.callback}
    else
      compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
      group_now = Group.find_all_by_extension(params[:id]).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime && g.days.exists?(:value => day)}
      phone = Phone.find_by_extension(params[:id])
      # Check if group w/ extension exists
      if group
        # If multiple groups exist, check for one matching the current time
        if group_now && group_now.size > 0 && group.enable
          group = group_now[0]
          count = group.counter
          if count >= group.phones.size
            count = 0
          end
          render :json => {:type => "Normal", :callerID => params[:caller_ID], :name => group['identity'], :identity => group.phones[count]['identity'], :size => group.phones.size, :number => group.phones[count]['number']}
            group.incrCounter(group)
        # Else if only one group exists, check if it matches the current time
        elsif group && group.enable && (group.start.hour.to_f + (group.start.min)/100.to_f <= compTime) && (group.endT.hour.to_f + (group.endT.min)/100.to_f >= compTime) && group.days.exists?(:value => day)
          count = group.counter
          if count >= group.phones.size
            count = 0
          end
          render :json => {:type => "Normal", :name => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number'] }
            group.incrCounter(group)
        # If no group matches time, but a phone matches extension return phone
        elsif phone
          render :json => {:name => phone["identity"], :identity => phone["identity"], :number => phone["number"]}
        else 
           render :json => {:number => false}
        end
      # If no group matches extension, but a phone matches
      elsif phone
        render :json => {:name => phone["identity"], :identity => phone["identity"], :number => phone["number"]}
      # If no groups or phone match extension
      else
        render :json => {:number => false}
      end   
    end
  end

  def finishCall
    newcall = Call.find_by_session(params[:session])
    newcall.answered= Phone.find_by_identity(params[:answered]).id
    newcall.target= Group.find_by_identity(params[:target]).id
    newcall.caller_ID = params[:callerID]
    newcall.was_connected = params[:connected]
    newcall.menuTime = params[:time]
    newcall.session = params[:session]
    newcall.save	
  end

  def startCall
    newcall = Call.new
    newcall.answered= Phone.find_by_extension('123').id
    newcall.target= Group.find_by_identity(params[:target]).id
    newcall.caller_ID = params[:callerID]
    newcall.was_connected = 'In Progress'
    newcall.menuTime = 'In Progress'
    newcall.session = params[:session]
    newcall.save
    UserMailer.incomingCall(params[:target], params[:callerID], params[:session]).deliver
  end

 

 end
