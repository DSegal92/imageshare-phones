
require 'net/http'
require 'uri'
require 'rubygems'
require 'json'

$answered
$target
$connected = false


ENV["TZ"] = "US/Eastern"

@http = Net::HTTP.new('imageshare-phones.herokuapp.com')

def getNumber(ext)
  response, data = @http.get "/calls/" + ext.to_s + "&caller_ID=" + $currentCall.sessionId.to_s, {}
  JSON.parse(data)
end
def dialPhone(ext)
 $answered = $contact["identity"].to_s
 $target = $contact["name"].to_s
say $contact["callerID"].to_s,
 {       :answerOnMedia => false,
  :playvalue => "http://www.phono.com/audio/holdmusic.mp3",
  :timeout => 20.0,
  :onTimeout => lambda { |event|
    $contact = getNumber(ext)
    dialPhone(ext)},

      :onSuccess => lambda { |event|
        $connected = true

      }
  }
  $endTime = (Time.new.to_i)
end

#Gets extension from user, loops if given bad extension
def getInput
  result = ask "For sales, press 1.  For support, press 2. For administrative questions, press 3. For anyone else, please enter their extension.",
  {
    :choices => "1, 2, 3, 4, 5, 6, 7",
    :timeout => 10.0,
    :attempts => 3,
    :onBadChoice => lambda { |event|
      say "I'm sorry, I didn't understand that."
      },

      :onChoice => lambda { |event|
        say "Transferring you now"

      }

     
    }
    extension = result.value
    $contact = getNumber(extension)
    if $contact["number"] == false
     say "No numbers with that extension were found."
     getInput
    else      
      #Dials Phone using extension from getInfo
      dialPhone(extension)
    end
 end

#Script Starts
startTime = (Time.new.to_i)
say "Thank you for calling Vigilant Medical Testing"
getInput


time = $endTime - startTime
if $connected == false
    $answered = 'Hang Up'
end