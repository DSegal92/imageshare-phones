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
  		@end_time = params[:ended]
  		@start_time = params[:started]
  		@elapsed = @end_time - @start_time
  		newcall.length = @elapsed.to_i
  		newcall.save  		
  end

 end
