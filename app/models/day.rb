class Day < ActiveRecord::Base
  attr_accessible :name, :value, :groups_ids

  has_and_belongs_to_many :groups
end
