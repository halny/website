# encoding: UTF-8

class Race < ActiveRecord::Base

  acts_as_paranoid

  scope :open_for_registration,
    lambda { where("registration_closed_at >= ?", DateTime.now).where("registration_open_from <= ?", DateTime.now) }

  has_many :race_variants, dependent: :destroy

  validates_presence_of :name, :description, :registration_open_from, :registration_closed_at

  validate :registration_open_before_close

  def registrations_total
    RaceRegistration.where(:race_variant_id => race_variant_ids).count
  end

  private

  def registration_open_before_close
    if registration_closed_at.present? && registration_open_from.present?
      errors.add(:registration_closed_at, 'musi być datą po otwarciu rejestracji') if registration_closed_at <= registration_open_from
    end
  end
end
