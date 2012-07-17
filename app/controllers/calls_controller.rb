class CallsController < ApplicationController
  def index
  end

  def show
    # If there is a group with the same extension as a phone, try group first
    if Group.find_by_extension(params[:id])
      time = Time.now.hour
      # Check if there is a group with given extension for current time block
      if Group.find_all_by_extension(params[:id]).select!{|g| 
        g.startTime <= time && g.endTime >= time}.nil?
        # Returns proper JSON if there is only one group for block and current time block
        if Group.find_by_extension(params[:id])
          group = Group.find_by_extension(params[:id])
          count = group.counter
          render :json => {:group => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number'] }
          group.counter = 1
        else
          # If no time blocks match current block, return a phone with the same extension if one exists
          if Phone.find_by_extension(params[:id])
            render :json => {:phone =>  Phone.find_by_extension(params[:id])["identity"], :number => Phone.find_by_extension(params[:id])["number"]}
          end
          # Returns that no such extension exists
          render :json => {:exists => false}
        end
      else
        # Returns proper JSON if there are multiple blocks and only one time matches
        group = Group.find_all_by_extension(params[:id]).select!{|g| 
          g.startTime < time && g.endTime > time}[0]
          count = group.counter
          render :json => {:group => group['identity'], :identity => group.phones[count]['identity'], :count => count, :number => group.phones[count]['number']}
          group.counter = 1
        end
      # Returns JSON if no extensions match, but a phone matches
      elsif Phone.find_by_extension(params[:id])
        render :json => {:phone =>  Phone.find_by_extension(params[:id])["identity"], :number => Phone.find_by_extension(params[:id])["number"]}
      # Returns False-- no extensions or phones match entered extension
      else
        render :json => {:exists => false}
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
