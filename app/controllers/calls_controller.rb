class CallsController < ApplicationController
  def index
  end

  def show
    group = Group.find_by_extension(params[:id])
    if Call.where(:caller_ID => params[:caller_ID]).where(:created_at => group.callback.days.ago..Time.now).exists?
      call = Call.where(:caller_ID => params[:caller_ID]).where(:created_at => group.callback.days.ago..Time.now).first()
      phone = Phone.find_by_identity(call.answered)
      render :json => {:name => call.target + " (Callback)", :identity => call.answered, :number => phone.number, :callback => group.callback}
      UserMailer.callBack(phone.email, params[:callerID], call.notes, params[:session]).deliver
    else
      compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
      group_now = Group.find_all_by_extension(params[:id]).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime}
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
        elsif group && group.enable && (group.start.hour.to_f + (group.start.min)/100.to_f <= compTime) && (group.endT.hour.to_f + (group.endT.min)/100.to_f >= compTime)
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
