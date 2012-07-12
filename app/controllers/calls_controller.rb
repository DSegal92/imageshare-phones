class CallsController < ApplicationController
  def index
    Tropo::Generator.say 'Hello World!'
  end

 
 end
