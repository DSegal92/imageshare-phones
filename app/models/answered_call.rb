class AnsweredCall < ActiveRecord::Base
  attr_accessible :call_id, :elapsed, :identity, :phone_id, :was_target
end
