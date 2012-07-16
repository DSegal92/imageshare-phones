class CallsController < ApplicationController
  def index
    @test = "Hello"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  def show

  end

  def new
  	newcall = Call.create 
  		newcall.target= params[:destination]
  		newcall.origin = params[:origin]
  		newcall.caller_ID = params[:callerID]
      newcall.length = params[:ended].to_i - params[:started].to_i + " s"
  		newcall.save  		
  end

 end
