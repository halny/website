class RaceVariant < ActiveRecord::Base

  belongs_to :race
  has_many :race_registrations

  def left
    capacity - race_registrations.count
  end

  def no_places_left?
    left <= 0
  end
end
