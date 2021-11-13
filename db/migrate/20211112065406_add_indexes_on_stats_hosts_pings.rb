class AddIndexesOnStatsHostsPings < ActiveRecord::Migration[6.1]
  def change
    add_index :stats_hosts_pings, [:host_id, :created_at]
    add_index :stats_hosts_pings, [:id, :created_at]
  end
end
