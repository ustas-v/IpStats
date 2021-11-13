class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.inet :ip_address, null: false
      t.integer :state, null: false, default: 0

      t.timestamps
    end

    add_index :hosts, :ip_address, unique: true
  end
end
