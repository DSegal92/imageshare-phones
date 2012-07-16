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
  		@end_time = params[:ended]
  		@start_time = params[:started]

  		@elapsed = @end_time.to_f
  		newcall.length = @elapsed.to_s
  		newcall.save  		
  end

 end
