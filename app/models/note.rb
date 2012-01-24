class Note < ActiveRecord::Base

  attr_accessible :content, :title, :pos_x, :pos_y, :z_index

  def to_json(options = {})
    if options.empty?
      super(:only => [:id, :content, :title, :pos_x, :pos_y, :z_index])
    else
      super
    end
  end

end
