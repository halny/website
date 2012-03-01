# encoding: UTF-8

require 'csv'

class RaceRegistration < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :race_variant
  belongs_to :user

  attr_accessible :name, :lastname, :email, :telephone, :is_student, :is_member

  validates_presence_of :name, :lastname, :email

  def paid_amount
    paid || 0
  end

  def self.to_csv(registrations)
    data = CSV.generate(col_sep: "\t") do |csv|
      csv << ['Osoba', 'Email', 'Telefon', 'Student?', 'Halniak?', 'Zapłacone']
      registrations.each do |r|
        row = []
        row << "#{r.name} #{r.lastname}"
        row << r.email
        row << r.telephone
        row << (r.is_student? ? "TAK" : "nie")
        row << (r.is_member? ? "TAK" : "nie")
        row << r.paid_amount
        csv << row
      end
    end
  end
end
