require 'net/http'

class Call < ActiveRecord::Base
  attr_accessible :answered, :caller_ID, :location, :notes, :origin, :target, :was_connected, :menuTime, :timesCalled, :site

  scope :connected_calls, where(:was_connected => true)
  scope :hang_ups, where(:was_connected => false)
  scope :all

  # Converts time to prettier formation xx:xx:xx
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

  # Will fetch and display Sites. For now hardcoded, but can be retrieved once website response is fixed
  def getSites
  	#cmd = %x[curl static.sharemedicalimages.com/admin/site/list]
  	#result = JSON.parse(cmd)
  	#resp = Net::HTTP.get_response("static.sharemedicalimages.com", "/admin/site/list")
  	#@result = JSON.parse(resp.body)
  	sites = ["wmc", "urmc", "symetis", "sibley", "jhm-uae", "geisinger", "proxy", "lexheart", "mtsmc", "jhuqca", 
      "icls", "pinehurst", "uf", "fallon", "advocate", "uams", "mayo", "cvc", "mhyork", "cumberland", "sparks", 
      "gbmc", "aahs", "beebemed", "cnmc", "choa", "austinheart", "arheart", "cairo", "directflow", "baylor", 
      "miami", "hays", "mhi", "ucsd", "hsh", "lacard", "jefferson", "dhmc", "penn", "umich", "nus", "lvhn", 
      "whcrad", "scripps", "uva", "imageshare", "usc", "umh", "ace", "cumc", "cchvc", "duke", "cic", "jhnccu", 
      "mmc", "whc", "mycvimage", "shvi", "jhcardio", "mct", "upmc", "tauberg", "loudoun", "wsh", "yh", "nyph", 
      "wcmc", "wpahs", "ccf", "umm", "abbott", "stanford", "cchs", "tmmc", "mah", "ca", "hms", "peace", "dev", 
      "ucla", "wah", "swedish", "nmr", "wustl", "prmc", "sfhc", "huh", "suttermc", "phsj", "fcvmed", "bsc", "ctag", 
      "emory", "edwards", "rush", "medtronic", "cshi", "pia", "jhneuro", "cth", "static", "uc"]
    # Formats sites roughly, assuming anything 4 or less characters are acronyms
    sites.each do |site|
      if site.length <= 4
        site = site.upcase!
      else
        site = site.capitalize!
      end
    end
  sites.sort()
  end
end
  
