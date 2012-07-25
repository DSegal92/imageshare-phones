class CallsController < ApplicationController
  def index
  end

  def show

    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    group = Group.find_by_extension(params[:id])
    group_now = Group.find_all_by_enable(true).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime}.sort_by{|x| x.extension}
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
        render :json => {:name2 => group['identity'], :identity => group.phones[count]['identity'], :size => group.phones.size, :number => group.phones[count]['number'] }
          group.incrCounter(group)
      # Else if only one group exists, check if it matches the current time
      elsif group && group.enable && (group.start.hour.to_f + (group.start.min)/100.to_f <= compTime) && (group.endT.hour.to_f + (group.endT.min)/100.to_f >= compTime)
        count = group.counter
        if count >= group.phones.size
          count = 0
        end
        render :json => {:name1 => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number'] }
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

  def finishCall
    newcall = Call.find_by_session(params[:session])
    newcall.answered= params[:answered]
    newcall.target= params[:target]
    newcall.caller_ID = params[:callerID]
    newcall.was_connected = params[:connected]
    newcall.menuTime = params[:time]
    newcall.session = params[:session]
    newcall.save	
  end

  def startCall
    newcall = Call.new
    newcall.answered= 'In Progress'
    newcall.target= params[:target]
    newcall.caller_ID = params[:callerID]
    newcall.was_connected = 'In Progress'
    newcall.menuTime = 'In Progress'
    newcall.session = params[:session]
    newcall.save
    UserMailer.incomingCall(params[:target], params[:callerID], params[:session]).deliver
  end

 

 end
