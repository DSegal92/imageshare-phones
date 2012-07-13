class CallsController < ApplicationController
  def index
  end

  def show
  end

  def new
  	newcall = Call.create
  		newcall.target= params[:destination]
  		newcall.save
  end

 end
