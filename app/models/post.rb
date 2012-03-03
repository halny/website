class Post < ActiveRecord::Base

  scope :published, lambda { where('published_at IS NOT NULL').where('published_at <= ?', Time.now).order('published_at DESC') }

  validates_presence_of :title, :content

  def visible?
    published_at.present? && published_at <= Time.now
  end
end
