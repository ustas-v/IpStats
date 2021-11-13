# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_12_065406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"

  create_table "hosts", force: :cascade do |t|
    t.inet "ip_address", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ip_address"], name: "index_hosts_on_ip_address", unique: true
  end

  create_table "stats_hosts_pings", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.bigint "host_id", null: false
    t.decimal "rtt", precision: 8, scale: 3
    t.decimal "mdev", precision: 8, scale: 3
    t.integer "packet_loss_percent", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "stats_hosts_pings_created_at_idx", order: :desc
    t.index ["host_id", "created_at"], name: "index_stats_hosts_pings_on_host_id_and_created_at"
    t.index ["id", "created_at"], name: "index_stats_hosts_pings_on_id_and_created_at"
  end

end
