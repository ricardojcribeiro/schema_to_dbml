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
# It"s strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_230_405_123_456) do
  create_table "users", comment: "Represents a user who can create blog posts and comments" do |t|
    t.string "name", null: false, comment: "Name of the user"
    t.string "email", null: false, comment: "Email of the user"
    t.string "password",  default: -> { "(now() + 'P1Y'::interval)" }, null: false, comment: "Encrypted password"
    t.text "tags", array: true
    t.datetime "created_at", null: false, comment: "Timestamp of when the user was created"
    t.datetime "updated_at", null: false, comment: "Timestamp of when the user was last updated"
  end

  create_table "posts", comment: "Represents a blog post created by a user" do |t|
    t.string "title", default: "General Title", null: false, comment: "Title of the post"
    t.text "content", null: false, comment: "Content of the post"
    t.jsonb "context", default: {}
    t.text "internal_description", comment: "Internal description"
    t.bigint "user_id", null: false, comment: "Foreign key of the user who created the post"
    t.datetime "created_at", null: false, comment: "Timestamp of when the post was created"
    t.datetime "updated_at", null: false, comment: "Timestamp of when the post was last updated"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "comments",
               comment: "Represents a comment created by a user on a specific blog post" do |t|
    t.text "content", null: false, comment: "Content of the comment"
    t.bigint "user_id", null: false, comment: "Foreign key of the user who created the comment"
    t.bigint "post_id", null: false, comment: "Foreign key of the post that the comment belongs to"
    t.datetime "created_at", null: false, comment: "Timestamp of when the comment was created"
    t.datetime "updated_at", null: false, comment: "Timestamp of when the comment was last updated"
    t.index ["post_id"], name: "index_comments_on_post_id", unique: true
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  add_foreign_key "comments", "posts", column: "post_id"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "users", on_delete: :cascade
end
