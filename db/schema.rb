# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_220_618_190_816) do
  create_table 'cities', force: :cascade do |t|
    t.string 'name'
    t.integer 'location_key'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'weathers', force: :cascade do |t|
    t.json 'current'
    t.integer 'city_id', null: false
    t.json 'historical'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_weathers_on_city_id'
  end

  add_foreign_key 'weathers', 'cities'
end
