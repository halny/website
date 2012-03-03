class Post < ActiveRecord::Base

  acts_as_paranoid

  scope :published, lambda { where('published_at IS NOT NULL').where('published_at <= ?', Time.now).order('published_at DESC') }

  validates_presence_of :title, :content

  attr_accessible :title, :content, :published_at

  def visible?
    published_at.present? && published_at <= Time.now
  end
end
