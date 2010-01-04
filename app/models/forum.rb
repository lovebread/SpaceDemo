class Forum < ActiveRecord::Base
  # const var:
  FORUM_MAX_NAME_LENGTH = 255
  FORUM_MAX_DESC_LENGTH = 1000
  
  has_many :topics, :dependent => :delete_all
  has_many :posts, :through => :topics
  
  # validations:
  validates_presence_of :name
  validates_length_of :name, :maximum => FORUM_MAX_NAME_LENGTH
  validates_length_of :description, :maximum => FORUM_MAX_DESC_LENGTH
end
