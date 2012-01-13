class Note < ActiveRecord::Base

  attr_accessible :content, :title, :top, :left

  def to_json(options = {})
    if options.empty?
      super(:only => [:id, :content, :title, :left, :top])
    else
      super
    end
  end

end
