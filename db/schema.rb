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

ActiveRecord::Schema.define(version: 20160126133054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fees", force: true do |t|
    t.string   "rut"
    t.string   "email"
    t.date     "fecha_pago"
    t.string   "mes"
    t.float    "monto"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pagador"
    t.string   "mes_cuota"
    t.string   "estado"
  end

  add_index "fees", ["person_id"], name: "index_fees_on_person_id", using: :btree

  create_table "incomes", force: true do |t|
    t.datetime "fecha"
    t.float    "monto"
    t.string   "tipo"
    t.string   "document"
    t.string   "banco"
    t.string   "mediopago"
    t.integer  "person_id"
    t.integer  "workplace_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "incomes", ["person_id"], name: "index_incomes_on_person_id", using: :btree
  add_index "incomes", ["user_id"], name: "index_incomes_on_user_id", using: :btree
  add_index "incomes", ["workplace_id"], name: "index_incomes_on_workplace_id", using: :btree

  create_table "inscriptions", force: true do |t|
    t.string   "nro_registro"
    t.string   "rut"
    t.string   "nombres"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "sexo"
    t.string   "nacionalidad"
    t.date     "fecha_inscripcion"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "universidad"
    t.date     "fecha_titulo"
    t.string   "tipo_contrato"
    t.string   "estado"
    t.date     "fecha_solicitud"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "telefono"
    t.string   "celular"
    t.string   "email"
    t.string   "password"
    t.string   "password_confirmation"
  end

  create_table "offices", force: true do |t|
    t.string   "nombre"
    t.string   "region"
    t.string   "ciudad"
    t.string   "email"
    t.string   "contacto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "email"
    t.string   "rut"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "phone"
    t.string   "terms"
    t.date     "fechaterms"
    t.string   "completeeduc"
    t.string   "nombres"
    t.integer  "nro_registro"
    t.string   "apellido_paterno"
    t.string   "apellido_materno"
    t.string   "sexo"
    t.string   "nacionalidad"
    t.date     "fecha_inscripcion"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "universidad"
    t.date     "fecha_titulo"
    t.string   "lugar_trabajo"
    t.string   "tipo_contrato"
    t.integer  "workplase_id"
    t.integer  "workplace_id"
    t.text     "url"
    t.text     "certificado_html"
    t.string   "estado"
  end

  add_index "people", ["workplace_id"], name: "index_people_on_workplace_id", using: :btree
  add_index "people", ["workplase_id"], name: "index_people_on_workplase_id", using: :btree

  create_table "persondocuments", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "documento"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "persondocuments", ["person_id"], name: "index_persondocuments_on_person_id", using: :btree

  create_table "previousjobs", force: true do |t|
    t.string   "establecimiento"
    t.string   "ciudad"
    t.string   "region"
    t.date     "desde"
    t.date     "hasta"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "previousjobs", ["person_id"], name: "index_previousjobs_on_person_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workplaces", force: true do |t|
    t.string   "nombre"
    t.string   "ciudad"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wpdocuments", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "documento"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpdocuments", ["workplace_id"], name: "index_wpdocuments_on_workplace_id", using: :btree

end
