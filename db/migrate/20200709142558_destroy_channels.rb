class DestroyChannels < ActiveRecord::Migration[6.0]
  def change
    drop_table :channels
  end
end
