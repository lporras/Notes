class AddZindexToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :z_index, :integer, :default => 0
  end
end
