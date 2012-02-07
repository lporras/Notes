class Note < ActiveRecord::Base

  attr_accessible :content, :title, :pos_x, :pos_y, :z_index

  after_create :track_creation

  def to_json(options = {})
    if options.empty?
      super(:only => [:id, :content, :title, :pos_x, :pos_y, :z_index])
    else
      super
    end
  end

  private

  def track_creation
    Pusher['notes'].trigger!('created', to_json)
  end
end
