class CreateInvTypes < ActiveRecord::Migration
  def self.up
    create_table :inv_types do |t|
      t.integer :type_id
      t.string :name
      t.float :volume
      t.float :buy
      t.float :sell

      t.timestamps
    end
  end

  def self.down
    drop_table :inv_types
  end
end
