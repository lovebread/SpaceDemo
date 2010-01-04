class Topic < ActiveRecord::Base
  # const var:
  TOPIC_MAX_NAME_LENGTH = 255
  
  belongs_to :forum, :counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :delete_all

  validates_presence_of :name
  validates_length_of :name, :maximum => TOPIC_MAX_NAME_LENGTH
end
