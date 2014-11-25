class Move < ActiveRecord::Base
  validates :name, presence: true

  def self.number_of_moves_with_name(name)
    where(name: name).count
  end
end
