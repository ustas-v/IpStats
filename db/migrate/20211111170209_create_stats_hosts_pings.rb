class CreateStatsHostsPings < ActiveRecord::Migration[6.1]
  def up
    create_table :stats_hosts_pings, id: false do |t|
      t.bigint :id, null: false
      t.references :host, null: false, index: false
      t.decimal :rtt, precision: 8, scale: 3
      t.decimal :mdev, precision: 8, scale: 3
      t.integer :packet_loss_percent, null: false, default: 0

      t.timestamps
    end

    execute <<-SQL
      CREATE SEQUENCE stats_hosts_pings_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
      ALTER SEQUENCE stats_hosts_pings_id_seq OWNED BY stats_hosts_pings.id;
      ALTER TABLE stats_hosts_pings ALTER COLUMN id SET DEFAULT nextval('stats_hosts_pings_id_seq'::regclass);
    SQL
  end

  def down
    drop_table :stats_hosts_pings
  end
end
