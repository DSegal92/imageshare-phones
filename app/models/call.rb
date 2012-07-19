class Call < ActiveRecord::Base
  attr_accessible :answered, :caller_ID, :location, :notes, :origin, :target, :was_connected, :menuTime, :timesCalled, :site
  def getTime(time)
  	time = time.to_i
	hours = (time / 3600)
		hourPrint = hours.to_s
		if hours < 10
			hourPrint = '0' + hours.to_s
		end
	minutes = (time / 60) - (hours * 60)
		minutePrint = minutes.to_s
		if minutes < 10
				minutePrint = '0' + minutes.to_s
			end
	seconds = time % 60
		secondPrint = seconds.to_s
		if seconds < 10
				secondPrint = '0' + seconds.to_s
			end
	hourPrint + ':' + minutePrint + ':' + secondPrint
	
  end
end
