class CallsController < ApplicationController
  def index
  end

  def show
  end

  def new
  	v = Tropo::Generator.parse request.env["rack.input"].read
  	newcall = Call.create 
  		newcall.target= params[:destination]
  		newcall.origin = params[:origin]
  		newcall.caller_ID = params[:callerID]
  	
  		newcall.save  		
  end

 end
