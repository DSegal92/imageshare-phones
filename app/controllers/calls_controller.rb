class CallsController < ApplicationController
  def index
     @test = "Hello"
  end

  def show

  end

  def new
  	newcall = Call.create 
  		newcall.target= params[:destination]
  		newcall.origin = params[:origin]
  		newcall.caller_ID = params[:callerID]
      newcall.length = params[:started] - params[:ended]
  		newcall.save  		
  end

 end
