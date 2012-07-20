class UserMailer < ActionMailer::Base

default from: "postmaster@vigilantnotifier.mailgun.org"
  		  

  def incomingCall(target, caller)
  	mail(to: 'DSegal92@gmail.com', :subject => "New Call for " + target)
  end

   
end
