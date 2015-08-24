class CreateSnacks < ActiveRecord::Migration
def up
    create_table :snacks do |t|
      t.integer :user_id
      t.string  :snack
      t.integer :receiver_id
      t.timestamps null: false
    end
  end
  def down
    drop_table :snacks
  end
end
