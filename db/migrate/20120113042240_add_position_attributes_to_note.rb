class AddPositionAttributesToNote < ActiveRecord::Migration
  def change
    add_column :notes, :left, :string, :default => "0px"
    add_column :notes, :top, :string, :default => "47px"
  end
end
