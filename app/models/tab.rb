class Tab < ActiveRecord::Base

  acts_as_paranoid

  attr_accessible :from, :to, :organizers, :name, :finish, :place

  searchable do
    text :organizers, :name, :finish, :place
    text :date do
      time_interval_str
    end
  end

  def time_interval_str
    if from.year != to.year
      [
        I18n.l(from.to_date, format: :long),
        I18n.l(to.to_date, format: :long)
      ].join(" - ")
    elsif from.at_beginning_of_month != to.at_beginning_of_month
      [
        I18n.l(from.to_date, format: "%e %B"),
        I18n.l(to.to_date, format: :long)
      ].join(" - ")
    elsif from.at_beginning_of_day != to.at_beginning_of_day
      [
        I18n.l(from.to_date, format: "%e"),
        I18n.l(to.to_date, format: :long)
      ].join(" - ")
    else
      I18n.l from.to_date, format: :long
    end
  end
end
