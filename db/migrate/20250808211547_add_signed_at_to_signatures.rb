class AddSignedAtToSignatures < ActiveRecord::Migration[7.1]
  def change
    add_column :signatures, :signed_at, :datetime
  end
end
