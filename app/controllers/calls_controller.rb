class CallsController < ApplicationController
  def index
  end

  def show
  end

  def new
  	newcall = Call.create 
  		newcall.target= params[:destination]
  		newcall.origin = params[:origin]
  		newcall.caller_ID = params[:callerID]
  		newcall.length = params[:start] - params[:endT]
  		newcall.save  		
  end

 end
