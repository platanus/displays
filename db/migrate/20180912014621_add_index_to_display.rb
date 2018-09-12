class AddIndexToDisplay < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    add_index :displays, :host_uuid, unique: true, algorithm: :concurrently
  end
end
