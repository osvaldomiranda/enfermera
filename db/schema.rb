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

ActiveRecord::Schema.define(version: 20180103135505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefits", force: true do |t|
    t.string   "institucion"
    t.string   "resumen"
    t.string   "imagen"
    t.text     "web"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "benefits", ["office_id"], name: "index_benefits_on_office_id", using: :btree

  create_table "blogs", force: true do |t|
    t.string   "titulo"
    t.text     "descripcion"
    t.string   "imagen"
    t.string   "documento"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "candidates", force: true do |t|
    t.string   "candidato"
    t.integer  "position_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidates", ["position_id"], name: "index_candidates_on_position_id", using: :btree
  add_index "candidates", ["vote_id"], name: "index_candidates_on_vote_id", using: :btree

  create_table "cost_centers", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counties", force: true do |t|
    t.string   "name"
    t.integer  "state_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "counties", ["name"], name: "index_counties_on_name", unique: true, using: :btree
  add_index "counties", ["state_id"], name: "index_counties_on_state_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currentfees", force: true do |t|
    t.float    "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
  end

  create_table "dailies", force: true do |t|
    t.integer  "numero"
    t.date     "fecha"
    t.integer  "cost_center_id"
    t.integer  "account_id"
    t.integer  "debe"
    t.integer  "haber"
    t.string   "numdocumento"
    t.string   "detalle"
    t.string   "paguesea"
    t.string   "por"
    t.string   "tipo"
    t.integer  "office_id"
    t.integer  "income_id"
    t.integer  "expense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banco"
    t.integer  "head_daily_id"
    t.integer  "workplace_id"
    t.string   "estado"
  end

  add_index "dailies", ["account_id"], name: "index_dailies_on_account_id", using: :btree
  add_index "dailies", ["cost_center_id"], name: "index_dailies_on_cost_center_id", using: :btree
  add_index "dailies", ["expense_id"], name: "index_dailies_on_expense_id", using: :btree
  add_index "dailies", ["head_daily_id"], name: "index_dailies_on_head_daily_id", using: :btree
  add_index "dailies", ["income_id"], name: "index_dailies_on_income_id", using: :btree
  add_index "dailies", ["office_id"], name: "index_dailies_on_office_id", using: :btree
  add_index "dailies", ["workplace_id"], name: "index_dailies_on_workplace_id", using: :btree

  create_table "detail_expenses", force: true do |t|
    t.string   "numcomprobante"
    t.float    "debe"
    t.float    "haber"
    t.string   "paguesea"
    t.string   "por"
    t.string   "observacion"
    t.integer  "account_id"
    t.integer  "cost_center_id"
    t.integer  "expense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "detail_expenses", ["account_id"], name: "index_detail_expenses_on_account_id", using: :btree
  add_index "detail_expenses", ["cost_center_id"], name: "index_detail_expenses_on_cost_center_id", using: :btree
  add_index "detail_expenses", ["expense_id"], name: "index_detail_expenses_on_expense_id", using: :btree

  create_table "detail_incomes", force: true do |t|
    t.string   "pcontable"
    t.string   "fcontable"
    t.string   "tipo_comprobante"
    t.string   "mescuota"
    t.string   "detalle"
    t.float    "debe"
    t.float    "haber"
    t.string   "obeservacion"
    t.integer  "account_id"
    t.integer  "workplace_id"
    t.integer  "cost_center_id"
    t.integer  "income_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "detail_incomes", ["account_id"], name: "index_detail_incomes_on_account_id", using: :btree
  add_index "detail_incomes", ["cost_center_id"], name: "index_detail_incomes_on_cost_center_id", using: :btree
  add_index "detail_incomes", ["income_id"], name: "index_detail_incomes_on_income_id", using: :btree
  add_index "detail_incomes", ["workplace_id"], name: "index_detail_incomes_on_workplace_id", using: :btree

  create_table "expenses", force: true do |t|
    t.datetime "fecha"
    t.float    "monto"
    t.string   "tipo"
    t.string   "document"
    t.string   "descripcion"
    t.string   "mediopago"
    t.integer  "office_id"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "expenses", ["office_id"], name: "index_expenses_on_office_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

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
    t.integer  "income_id"
    t.integer  "nro_registro"
    t.datetime "fecha_contable"
    t.datetime "mescuota"
  end

  add_index "fees", ["income_id"], name: "index_fees_on_income_id", using: :btree
  add_index "fees", ["person_id"], name: "index_fees_on_person_id", using: :btree

  create_table "head_dailies", force: true do |t|
    t.integer  "numero"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
    t.string   "paguesea"
    t.string   "por"
    t.string   "banco"
    t.string   "recibidode"
    t.string   "mediopago"
    t.string   "numcheque"
    t.string   "documento"
    t.integer  "office_id"
    t.integer  "workplace_id"
    t.datetime "fecha_contable"
    t.string   "rut"
    t.string   "estado"
    t.integer  "folio_office"
  end

  add_index "head_dailies", ["office_id"], name: "index_head_dailies_on_office_id", using: :btree
  add_index "head_dailies", ["user_id"], name: "index_head_dailies_on_user_id", using: :btree
  add_index "head_dailies", ["workplace_id"], name: "index_head_dailies_on_workplace_id", using: :btree

  create_table "image_buckets", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "estado"
    t.integer  "office_id"
    t.datetime "fecha_pago"
    t.datetime "fecha_contable"
    t.string   "mes_cuota"
  end

  add_index "incomes", ["office_id"], name: "index_incomes_on_office_id", using: :btree
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
    t.integer  "workplace_id"
    t.string   "forma_pago"
    t.string   "origen"
    t.string   "pais_origen"
    t.string   "url"
    t.text     "certificado_html"
    t.integer  "user_id"
  end

  add_index "inscriptions", ["user_id"], name: "index_inscriptions_on_user_id", using: :btree
  add_index "inscriptions", ["workplace_id"], name: "index_inscriptions_on_workplace_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "titulo"
    t.text     "descripcion"
    t.string   "contacto"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "fecha_desde"
    t.date     "fecha_hasta"
    t.integer  "num_dias"
  end

  create_table "magazines", force: true do |t|
    t.string   "titulo"
    t.string   "descripcion"
    t.string   "portada"
    t.string   "documento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "fecha"
  end

  create_table "national_councils", force: true do |t|
    t.string   "nombre"
    t.string   "imagen"
    t.string   "cargo"
    t.string   "curriculum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "web"
    t.integer  "prioridad"
  end

  create_table "officeaccounts", force: true do |t|
    t.date     "fecha"
    t.string   "tipo"
    t.float    "monto"
    t.string   "codigo"
    t.string   "account"
    t.integer  "user_id"
    t.integer  "office_id"
    t.integer  "income_id"
    t.integer  "expense_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "incomevalue"
    t.float    "expensevalue"
  end

  add_index "officeaccounts", ["expense_id"], name: "index_officeaccounts_on_expense_id", using: :btree
  add_index "officeaccounts", ["income_id"], name: "index_officeaccounts_on_income_id", using: :btree
  add_index "officeaccounts", ["office_id"], name: "index_officeaccounts_on_office_id", using: :btree
  add_index "officeaccounts", ["user_id"], name: "index_officeaccounts_on_user_id", using: :btree

  create_table "offices", force: true do |t|
    t.string   "nombre"
    t.string   "region"
    t.string   "ciudad"
    t.string   "email"
    t.string   "contacto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo"
    t.string   "calle"
    t.string   "numero"
    t.string   "telefono"
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
    t.integer  "workplace_id"
    t.text     "url"
    t.text     "certificado_html"
    t.string   "estado"
    t.string   "forma_pago"
    t.string   "codigo"
    t.string   "nombre_completo"
    t.string   "origen"
    t.string   "telefono"
    t.string   "celular"
    t.string   "certificado_file"
    t.boolean  "candidate"
  end

  add_index "people", ["workplace_id"], name: "index_people_on_workplace_id", using: :btree

  create_table "persondocuments", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "documento"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "persondocuments", ["person_id"], name: "index_persondocuments_on_person_id", using: :btree

  create_table "positions", force: true do |t|
    t.string   "cargo"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["vote_id"], name: "index_positions_on_vote_id", using: :btree

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

  create_table "publications", force: true do |t|
    t.string   "titulo"
    t.string   "texto"
    t.string   "resumen"
    t.string   "imagen"
    t.string   "tipo"
    t.string   "documeto"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "web"
    t.date     "fecha_desde"
    t.date     "fecha_hasta"
  end

  create_table "regional_councils", force: true do |t|
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "web"
  end

  add_index "regional_councils", ["office_id"], name: "index_regional_councils_on_office_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rols", force: true do |t|
    t.string   "nombre"
    t.integer  "user_id"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rols", ["user_id"], name: "index_rols_on_user_id", using: :btree

  create_table "scientific_societies", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.string   "logo"
    t.string   "direccion"
    t.string   "telefono"
    t.string   "contacto"
    t.string   "web_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "states", ["name"], name: "index_states_on_name", unique: true, using: :btree

  create_table "user_alow_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_alow_votes", ["user_id"], name: "index_user_alow_votes_on_user_id", using: :btree
  add_index "user_alow_votes", ["vote_id"], name: "index_user_alow_votes_on_vote_id", using: :btree

  create_table "user_votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "xmlfile"
    t.string   "pngfile"
  end

  add_index "user_votes", ["user_id"], name: "index_user_votes_on_user_id", using: :btree
  add_index "user_votes", ["vote_id"], name: "index_user_votes_on_vote_id", using: :btree

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
    t.integer  "roles_mask"
    t.string   "rut"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: true do |t|
    t.string   "titulo"
    t.string   "alojamiento"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.date     "fecha"
    t.string   "votacion"
    t.string   "descripcion"
    t.string   "inicio"
    t.string   "termino"
    t.string   "estado"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipo"
  end

  create_table "vows", force: true do |t|
    t.string   "token"
    t.integer  "candidate_id"
    t.integer  "position_id"
    t.integer  "vote_id"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vowfile"
  end

  add_index "vows", ["candidate_id"], name: "index_vows_on_candidate_id", using: :btree
  add_index "vows", ["position_id"], name: "index_vows_on_position_id", using: :btree
  add_index "vows", ["vote_id"], name: "index_vows_on_vote_id", using: :btree
  add_index "vows", ["workplace_id"], name: "index_vows_on_workplace_id", using: :btree

  create_table "workplaces", force: true do |t|
    t.string   "nombre"
    t.string   "ciudad"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "codigo"
    t.string   "telefono"
    t.string   "email"
    t.string   "calle"
    t.string   "numero"
    t.integer  "office_id"
    t.string   "cod_wp"
    t.string   "cod_serv_salud"
    t.string   "serv_salud"
  end

  add_index "workplaces", ["office_id"], name: "index_workplaces_on_office_id", using: :btree

  create_table "wpdiscounts", force: true do |t|
    t.string   "discountfile"
    t.string   "email"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpdiscounts", ["workplace_id"], name: "index_wpdiscounts_on_workplace_id", using: :btree

  create_table "wpdocuments", force: true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.string   "documento"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpdocuments", ["workplace_id"], name: "index_wpdocuments_on_workplace_id", using: :btree

  create_table "wpemails", force: true do |t|
    t.string   "email"
    t.integer  "workplace_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wpemails", ["workplace_id"], name: "index_wpemails_on_workplace_id", using: :btree

end
