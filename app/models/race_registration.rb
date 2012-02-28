class RaceRegistration < ActiveRecord::Base

  belongs_to :race_variant
  belongs_to :user

  attr_accessible :name, :lastname, :email, :telephone, :is_student, :is_member

  validates_presence_of :name, :lastname, :email
end
