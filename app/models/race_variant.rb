class RaceVariant < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :race
  has_many :race_registrations, dependent: :destroy

  validates_presence_of :name, :description, :capacity
  validates_numericality_of :capacity, only_integer: true

  def left
    capacity - race_registrations.count
  end

  def no_places_left?
    left <= 0
  end
end
