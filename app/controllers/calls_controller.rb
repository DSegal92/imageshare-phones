class CallsController < ApplicationController
  def index
  end

  def show
  end

  def new
  	newcall = Call.create
  		newcall.destination = params[:destination]
  		newcall.save
  end

 end
