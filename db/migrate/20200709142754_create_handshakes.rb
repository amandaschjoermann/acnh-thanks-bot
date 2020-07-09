class CreateHandshakes < ActiveRecord::Migration[6.0]
  def change
    create_table :handshakes do |t|
      t.references :thanker, foreign_key: { to_table: 'users' }
      t.references :thankee, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
