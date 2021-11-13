class AddMigrationStatsHostsPingToTimescaleDb < ActiveRecord::Migration[6.1]
  def up
    enable_extension('timescaledb') unless extensions.include? 'timescaledb'

    execute <<-SQL
      SELECT create_hypertable('stats_hosts_pings', 'created_at', chunk_time_interval => INTERVAL '1 day');
    SQL
  end

  def down
  end
end
