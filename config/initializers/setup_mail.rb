ActionMailer::Base.smtp_settings = {
	:address				=> "smtp.mailgun.org",
	:port					=> "587",
	:domain					=> "vigilant-accounts.herokuapp.com",
	:user_name				=> "postmaster@vigilantnotifier.mailgun.org",
	:password				=> "598bhlc9xzo5",
	:authentication 		=> "plain"
}

ActionMailer::Base.delivery_method = :smtp