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
      newcall.was_connected = params[:connected]
  		newcall.save  		
  end

 end
