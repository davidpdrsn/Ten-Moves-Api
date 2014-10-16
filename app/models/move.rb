class Move < ActiveRecord::Base
  scope :most_recent, -> { order(created_at: :desc).limit(10) }
end
