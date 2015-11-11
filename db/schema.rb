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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151111130738) do

  create_table "cells", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "carved_north", default: false
    t.boolean  "carved_south", default: false
    t.boolean  "carved_east",  default: false
    t.boolean  "carved_west",  default: false
  end

  create_table "maze_cells", force: :cascade do |t|
    t.integer "maze_id"
    t.integer "cell_id"
    t.integer "x"
    t.integer "y"
    t.boolean "starting_cell", default: false
    t.boolean "ending_cell",   default: false
  end

  create_table "mazes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "generator"
    t.integer  "width"
    t.integer  "height"
  end

end
