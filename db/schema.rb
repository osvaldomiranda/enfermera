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

ActiveRecord::Schema.define(version: 20151109144537) do

  create_table "bienes_raices", force: true do |t|
    t.string   "tipo"
    t.string   "direccion"
    t.string   "valor_comercial"
    t.string   "rol"
    t.string   "hipoteca_banco"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bienes_raices", ["person_id"], name: "index_bienes_raices_on_person_id"

  create_table "dependents", force: true do |t|
    t.string   "empleador"
    t.string   "rut_empleador"
    t.string   "giro_empresa"
    t.string   "direccion_empresa"
    t.string   "tipo_contrato"
    t.string   "cargo"
    t.string   "fecha_ingreso"
    t.string   "fecha_ingreso_anterior"
    t.string   "fecha_termino_anterior"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dependents", ["person_id"], name: "index_dependents_on_person_id"

  create_table "deuda_directa", force: true do |t|
    t.string   "tipo"
    t.string   "institucion"
    t.string   "cupo_aprobado"
    t.string   "deuda_vigente"
    t.string   "pago_mensual"
    t.string   "vencimineto"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deuda_directa", ["person_id"], name: "index_deuda_directa_on_person_id"

  create_table "deuda_indirecta", force: true do |t|
    t.string   "tipo"
    t.string   "institucion"
    t.string   "deuda_vigente"
    t.string   "razon_social"
    t.string   "rut"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deuda_indirecta", ["person_id"], name: "index_deuda_indirecta_on_person_id"

  create_table "direccions", force: true do |t|
    t.string   "tipo"
    t.string   "calle_num_depto"
    t.string   "comuna"
    t.string   "ciudad"
    t.string   "telefono"
    t.string   "celular"
    t.string   "codigo_postal"
    t.string   "tipo_vivienda"
    t.string   "dividendo_arriendo"
    t.string   "casilla"
    t.string   "num_correo"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "direccions", ["person_id"], name: "index_direccions_on_person_id"

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["person_id"], name: "index_documents_on_person_id"

  create_table "independents", force: true do |t|
    t.string   "tipo_rentista"
    t.string   "tipo_actividad"
    t.string   "giro_actividad"
    t.string   "fecha_inicio_rubro"
    t.string   "fecha_inicio_actividad"
    t.string   "nombre_empleador_anterior"
    t.string   "cargo"
    t.string   "antiguedad"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "independents", ["person_id"], name: "index_independents_on_person_id"

  create_table "ingresos", force: true do |t|
    t.string   "sueldo_fijo_mes"
    t.string   "sueldo_variable_mes"
    t.string   "arriendo"
    t.string   "vtas_anuales"
    t.string   "declaracion_renta"
    t.string   "honorarios_mes"
    t.string   "cta_cte"
    t.string   "banco"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "otros"
  end

  add_index "ingresos", ["person_id"], name: "index_ingresos_on_person_id"

  create_table "jubilados", force: true do |t|
    t.string   "ultimo_empleador"
    t.string   "institucion_pagadora"
    t.string   "afp"
    t.string   "cia_seguro"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jubilados", ["person_id"], name: "index_jubilados_on_person_id"

  create_table "people", force: true do |t|
    t.string   "email"
    t.string   "rut"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "nationality"
    t.string   "economic_activity"
    t.string   "education"
    t.string   "origin_country"
    t.string   "resident_country"
    t.string   "profession"
    t.integer  "dependents"
    t.string   "university"
    t.integer  "number_of_children"
    t.string   "marital_status"
    t.string   "matrimonial_regime"
    t.string   "date_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.string   "phone"
    t.string   "terms"
    t.date     "fechaterms"
    t.string   "completeeduc"
    t.string   "employmentsituation"
  end

  create_table "sociedads", force: true do |t|
    t.string   "tipo"
    t.string   "porcentaje"
    t.string   "capital"
    t.string   "nombre"
    t.string   "rut"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sociedads", ["person_id"], name: "index_sociedads_on_person_id"

  create_table "spouses", force: true do |t|
    t.string   "rut"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "nationality"
    t.string   "economic_activity"
    t.string   "education"
    t.string   "origin_country"
    t.string   "resident_country"
    t.string   "profession"
    t.string   "dependents"
    t.string   "university"
    t.integer  "number_of_children"
    t.string   "date_birth"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "adress"
    t.string   "phone"
    t.integer  "renta"
    t.date     "fechaingreso"
  end

  add_index "spouses", ["person_id"], name: "index_spouses_on_person_id"

  create_table "universitarios", force: true do |t|
    t.string   "email"
    t.string   "universidad"
    t.string   "carrera"
    t.string   "encurso"
    t.string   "renta_familiar"
    t.string   "nombre_padre"
    t.string   "rut_padre"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "universitarios", ["person_id"], name: "index_universitarios_on_person_id"

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

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehiculos", force: true do |t|
    t.string   "tipo"
    t.string   "marca"
    t.string   "modelo"
    t.string   "agno"
    t.string   "patente"
    t.string   "valor_comercia"
    t.string   "prenda_afavor"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehiculos", ["person_id"], name: "index_vehiculos_on_person_id"

end
