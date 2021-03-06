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

ActiveRecord::Schema.define(:version => 20131215090958) do

  create_table "available_times", :force => true do |t|
    t.integer  "user_id"
    t.datetime "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "available_times", ["user_id"], :name => "index_available_times_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "category_relations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "categorizable_id"
    t.string   "categorizable_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
  end

  add_index "category_relations", ["categorizable_id"], :name => "index_category_relations_on_categorizable_id"
  add_index "category_relations", ["category_id", "categorizable_id", "categorizable_type"], :name => "category_categorizable_index", :unique => true
  add_index "category_relations", ["category_id"], :name => "index_category_relations_on_category_id"
  add_index "category_relations", ["user_id"], :name => "index_category_relations_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "explanations", :force => true do |t|
    t.text     "content"
    t.integer  "problem_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "explanations", ["problem_id"], :name => "index_explanations_on_problem_id"
  add_index "explanations", ["user_id"], :name => "index_explanations_on_user_id"

  create_table "hints", :force => true do |t|
    t.text     "content"
    t.integer  "clarity"
    t.integer  "problem_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "hints", ["problem_id"], :name => "index_hints_on_problem_id"
  add_index "hints", ["user_id"], :name => "index_hints_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "online_judges", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "logo"
  end

  create_table "problems", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.integer  "online_judge_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "problems", ["link"], :name => "index_problems_on_link", :unique => true
  add_index "problems", ["online_judge_id"], :name => "index_problems_on_online_judge_id"

  create_table "public_links", :force => true do |t|
    t.integer  "unlockable_id"
    t.string   "unlockable_type"
    t.string   "hashed_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "public_links", ["unlockable_id"], :name => "index_public_links_on_unlockable_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "reviews", :force => true do |t|
    t.integer  "stars"
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "reviews", ["reviewable_id"], :name => "index_reviews_on_reviewable_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "scores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "scores", ["user_id"], :name => "index_scores_on_user_id"

  create_table "solutions", :force => true do |t|
    t.text     "code"
    t.integer  "language_id"
    t.integer  "problem_id"
    t.boolean  "accepted"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "private"
  end

  add_index "solutions", ["language_id"], :name => "index_solutions_on_language_id"
  add_index "solutions", ["problem_id"], :name => "index_solutions_on_problem_id"
  add_index "solutions", ["user_id"], :name => "index_solutions_on_user_id"

  create_table "unlocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "unlockable_id"
    t.string   "unlockable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "unlocks", ["unlockable_id"], :name => "index_unlocks_on_unlockable_id"
  add_index "unlocks", ["user_id"], :name => "index_unlocks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
