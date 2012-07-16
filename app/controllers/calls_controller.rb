class CallsController < ApplicationController
  def index
    render :json => {1}
  
  end

  def show

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
