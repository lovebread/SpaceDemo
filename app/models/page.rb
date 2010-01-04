class Page < ActiveRecord::Base
  
  # define const var
  TITLE_RANGE = 3..255
  BODY_MAX_LEN = 10000
  
  # 验证数据是否满足要求
  
  validates_presence_of :title, :body
  validates_length_of :title, :within => TITLE_RANGE
  validates_length_of :body, :maximum => BODY_MAX_LEN
  
  # validates_format_of :title
  
  def before_create
    @attributes['permalink'] = 
      title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
end
