class Note < ActiveRecord::Base

  attr_accessible :content, :title, :pos_x, :pos_y, :z_index

  def as_json(options = nil)
    super({
      :only => [:id, :content, :title, :pos_x, :pos_y, :z_index]
    }.merge(options))
  end

end
