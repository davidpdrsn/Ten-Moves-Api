class Move < ActiveRecord::Base
  validates :name, presence: true
end
