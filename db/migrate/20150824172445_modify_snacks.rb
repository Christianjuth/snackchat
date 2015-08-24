class ModifySnacks < ActiveRecord::Migration
  def up
    add_column :snacks, :seconds, :integer
  end
  
  def down
    remove_column :snacks, :seconds, :integer
  end
end
