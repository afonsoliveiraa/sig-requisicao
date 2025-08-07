class AddTokenAndStatusToSignatures < ActiveRecord::Migration[7.1]
  def change
    add_column :signatures, :signature_token, :string
    add_column :signatures, :status, :string
  end
end
