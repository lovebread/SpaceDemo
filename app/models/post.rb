class Post < ActiveRecord::Base
  # const var:
  POST_MAX_BODY_LENGTH = 10000
  
  belongs_to :topic, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates_presence_of :body
  validates_length_of :body, :maximum => POST_MAX_BODY_LENGTH
end
