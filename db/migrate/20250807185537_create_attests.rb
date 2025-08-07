class CreateAttests < ActiveRecord::Migration[7.1]
  def change
    create_table :attests do |t|
      t.string :system
      t.string :entity
      t.string :operation
      t.string :token
      t.integer :type_signature
      t.string :message

      t.timestamps
    end
  end
end
