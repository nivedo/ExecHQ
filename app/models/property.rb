class Property < ActiveRecord::Base
  belongs_to :manager
  has_many :events
end
