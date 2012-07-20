class UserMailer < ActionMailer::Base

default from: "postmaster@vigilantnotifier.mailgun.org"
  		  

  def incomingCall()
  	mail(to: 'DSegal92@gmail.com', :subject => "This is a test")
  end

   
end
