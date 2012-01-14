class Note < ActiveRecord::Base

  attr_accessible :content, :title, :top, :left, :z_index

  def to_json(options = {})
    if options.empty?
      super(:only => [:id, :content, :title, :left, :top, :z_index])
    else
      super
    end
  end

end
