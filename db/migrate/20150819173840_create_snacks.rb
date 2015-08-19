class CreateSnacks < ActiveRecord::Migration
def up
    create_table :snacks do |t|
      t.string :username
      t.string :snack
      t.string :receiver
      t.integer :timestamp
    end
  end
  def down
    drop_table :snacks
  end
end
