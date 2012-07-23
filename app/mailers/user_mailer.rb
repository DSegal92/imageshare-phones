class UserMailer < ActionMailer::Base

default from: "postmaster@vigilantnotifier.mailgun.org"
  		  

  def incomingCall(email, target, caller, sessionID)
  	@email = email
    @call = Call.find_by_session(sessionID)
    @target = target
    @caller = caller
    @url = 'http://imageshare-phones.herokuapp.com/admin/calls/' + @call.id.to_s + '/edit'
  	mail(to: @email , :subject => "New Call for " + target)
  end

   
end
