class Post < ActiveRecord::Base

  scope :published, lambda { where('published_at IS NOT NULL').where('published_at <= ?', Time.now).order('published_at DESC') }
end
