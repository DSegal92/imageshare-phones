class CallsController < ApplicationController
  def index
  end

  def show
    time = Time.now.hour
    group = Group.find_by_extension(params[:id])
    group_now = Group.find_all_by_extension(params[:id]).select!{|g| g.startTime <= time && g.endTime >= time}
    phone = Phone.find_by_extension(params[:id])
    # Check if group w/ extension exists
    if group
      # If multiple groups exist, check for one matching the current time
      if group_now && group_now.size > 0 && group.enable
        group = group_now[0]
        count = group.counter
        render :json => {:group => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number'] }
          group.incrCounter(group)
      # Else if only one group exists, check if it matches the current time
      elsif group && group.startTime <= time && group.endTime >= time && group.enable
        count = group.counter
        render :json => {:group1 => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number'] }
          group.incrCounter(group)
      # If no group matches time, but a phone matches extension return phone
      elsif phone && phone.enable
        render :json => {:phone => phone["identity"], :number => phone["number"]}
      else 
         render :json => {:number => false}
      end
    # If no group matches extension, but a phone matches
    elsif phone && phone.enable
      render :json => {:phone => phone["identity"], :number => phone["number"]}
    # If no groups or phone match extension
    else
      render :json => {:number => false}
    end  
    
  end

  def new
    newcall = Call.create      
    newcall.target= params[:destination]
    newcall.origin = params[:origin]
    newcall.caller_ID = params[:callerID]
    newcall.length = params[:ended].to_i - params[:started].to_i
    newcall.save  		
  end

  

 end
