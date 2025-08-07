class CreateSignatures < ActiveRecord::Migration[7.1]
  def change
    create_table :signatures do |t|
      t.string :title
      t.string :cpf
      t.string :email
      t.string :name
      t.references :attest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
