class Note < ActiveRecord::Base

  attr_accessible :content, :title

  def to_json(options = {})
    if options.empty?
      super(:only => [:id, :content, :title])
    else
      super
    end
  end

end
