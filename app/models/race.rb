class Race < ActiveRecord::Base

  scope :open_for_registration,
    lambda { where("registration_closed_at >= ?", DateTime.now).where("registration_open_from <= ?", DateTime.now) }
end
