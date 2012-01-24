class RenamingColumnLeftForNotes < ActiveRecord::Migration
  def up
    rename_column :notes, :left, :pos_x
    rename_column :notes, :top,  :pos_y
  end

  def down
    rename_column :notes, :pos_x, :left
    rename_column :notes, :pos_y,  :top
  end
end
