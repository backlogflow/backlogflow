# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120614223006) do

  create_table "changes", :force => true do |t|
    t.integer   "story_id"
    t.integer   "old_points"
    t.integer   "new_points"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "home_accesses", :force => true do |t|
    t.boolean   "is_empty",   :default => false
    t.boolean   "is_new",     :default => false
    t.integer   "accesses",   :default => 0
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.string    "title"
    t.string    "description"
    t.string    "details"
    t.integer   "points"
    t.string    "value"
    t.string    "status"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "project_id"
    t.integer   "parent_story"
    t.integer   "order"
    t.integer   "position"
    t.datetime  "done_date"
  end

end
