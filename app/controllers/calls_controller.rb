class CallsController < ApplicationController
  def index
  end

    # Handles all call logic
  def show
    

    # Constants used for comparisons
    group = Group.find_by_extension(params[:id])
    phone = Phone.find_by_extension(params[:id])
    day = Time.now.wday
    compTime = Time.now.hour.to_f + (Time.now.min)/100.to_f
    group_now = Group.find_all_by_extension(params[:id]).select{|g| (g.start.hour.to_f + (g.start.min)/100.to_f) <= compTime && (g.endT.hour.to_f + (g.endT.min)/100.to_f) >= compTime && g.days.exists?(:value => day)}
    phone = Phone.find_by_extension(params[:id])


    # Check if group w/ extension exists
    if group 
      # If a call has come in for the group within the group's callback days, skips rest of logic to redirect to the last called person
      if Call.where(:caller_ID => params[:caller_ID]).where(:target => group.id.to_s).where(:created_at => group.callback.days.ago..Time.now).where(:was_connected => true).exists?
        call = Call.where(:caller_ID => params[:caller_ID]).where(:target => group.id.to_s).where(:created_at => group.callback.days.ago..Time.now).where(:was_connected => true).first()
        phone = Phone.find_by_id(call.answered)
        render :json => {:type => "Callback", :callerID => params[:caller_ID], :name => call.target, :identity => call.answered, :number => phone.number}
     
      # If multiple groups exist, check for one matching the current time
      elsif group_now && group_now.size > 0 && group.enable
        group = group_now[0]
        count = group.counter
        if count >= group.phones.size
          count = 0
        end
        render :json => {:type => "Normal (Multiple Groups)", :callerID => params[:caller_ID], :name => group['identity'], :identity => group.phones[count]['identity'], :number => group.phones[count]['number']}
          group.incrCounter(group)
      # Else if only one group exists, check if it matches the current time
      elsif group && group.enable && (group.start.hour.to_f + (group.start.min)/100.to_f <= compTime) && (group.endT.hour.to_f + (group.endT.min)/100.to_f >= compTime) && group.days.exists?(:value => day)
        count = group.counter
        if count >= group.phones.size
          count = 0
        end
        render :json => {:type => "Normal (Single Group)", :callerID => params[:caller_ID], :name => group['identity'], :identity => group.phones[count]['identity'], :number => group.phones[count]['number'] }
          group.incrCounter(group)
      # If no group matches time, but a phone matches extension return phone
      elsif phone
        render :json => {:type => "Phone (No Group in Time)", :callerID => params[:caller_ID], :name => phone["identity"], :identity => phone["identity"], :number => phone["number"]}
      else 
         render :json => {:number => false}
      end
    # If no group matches extension, but a phone matches
    elsif phone
      render :json => {:type => "Phone (No Group)", :callerID => params[:caller_ID], :name => phone["identity"], :identity => phone["identity"], :number => phone["number"]}
    # If no groups or phone match extension
    else
      render :json => {:number => false}
    end   
  end

  # POST, from Tropo app when callers disconnect
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

  # POST, runs as soon as caller chooses extension
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