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

ActiveRecord::Schema.define(version: 20160705150747) do

  create_table "conducts", force: :cascade do |t|
    t.string   "name"
    t.integer  "priority"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.float    "audition",   default: 0.0
    t.float    "semi_final", default: 0.0
    t.float    "final",      default: 0.0
    t.integer  "course_id"
    t.integer  "score_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "gpa",        default: 0.0
  end

  add_index "details", ["course_id"], name: "index_details_on_course_id"
  add_index "details", ["score_id"], name: "index_details_on_score_id"

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_classes", default: 40
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "klasses", force: :cascade do |t|
    t.string   "name"
    t.integer  "students_count", default: 0
    t.integer  "grade_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "teacher_id"
  end

  add_index "klasses", ["grade_id"], name: "index_klasses_on_grade_id"
  add_index "klasses", ["teacher_id"], name: "index_klasses_on_teacher_id"

  create_table "marks", force: :cascade do |t|
    t.string   "name"
    t.float    "point"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "rules", force: :cascade do |t|
    t.integer  "max_quantity", default: 40
    t.integer  "max_age",      default: 20
    t.integer  "min_age",      default: 15
    t.float    "max_point",    default: 10.0
    t.float    "min_point",    default: 0.0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "scores", force: :cascade do |t|
    t.float    "gpa",         default: 0.0
    t.integer  "student_id"
    t.integer  "semester_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "mark_id"
    t.integer  "conduct_id"
    t.integer  "ability_id"
  end

  add_index "scores", ["ability_id"], name: "index_scores_on_ability_id"
  add_index "scores", ["conduct_id"], name: "index_scores_on_conduct_id"
  add_index "scores", ["mark_id"], name: "index_scores_on_mark_id"
  add_index "scores", ["semester_id"], name: "index_scores_on_semester_id"
  add_index "scores", ["student_id"], name: "index_scores_on_student_id"

  create_table "semesters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.date     "date_of_birth"
    t.boolean  "gender",        default: true
    t.text     "address"
    t.string   "email"
    t.integer  "klass_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "last_name"
    t.float    "final_gpa"
    t.integer  "ability_id"
    t.integer  "mark_id"
    t.integer  "conduct_id"
    t.string   "student_code"
  end

  add_index "students", ["ability_id"], name: "index_students_on_ability_id"
  add_index "students", ["conduct_id"], name: "index_students_on_conduct_id"
  add_index "students", ["klass_id"], name: "index_students_on_klass_id"
  add_index "students", ["mark_id"], name: "index_students_on_mark_id"

  create_table "teachers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.boolean  "gender",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.integer  "student_id"
    t.integer  "teacher_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["student_id"], name: "index_users_on_student_id"
  add_index "users", ["teacher_id"], name: "index_users_on_teacher_id"

end
