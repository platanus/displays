class AddHostUuidToDisplay < ActiveRecord::Migration[5.2]
  def change
    add_column :displays, :host_uuid, :string
  end
end
