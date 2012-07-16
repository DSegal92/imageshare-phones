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
      started = params[:started].to_f
      ended = params[:ended].to_f
      newcall.length = started
  		newcall.save  		
  end

 end
