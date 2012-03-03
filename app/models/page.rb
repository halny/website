class Page < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :slugged

  acts_as_paranoid

  validates_presence_of :name, :content

  scope :active, where(active: true)
  scope :for_navbar, active.where(show_in_navbar: true)
end
