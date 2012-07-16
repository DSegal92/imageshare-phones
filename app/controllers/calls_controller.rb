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
      started = params[:started]
      ended = params[:ended]
      newcall.length = started.to_i
  		newcall.save  		
  end

 end
