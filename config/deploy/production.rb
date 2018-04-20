set :ip, "52.33.58.120"
# set :ip, "35.160.119.161" 
set :rails_env, 'production'
server "#{ip}", :web, :app, :db, primary: true,
  ssh_options: {
     keys: %w(/Users/osvaldo/.ssh/id_rsa),
     forward_agent: true,
     auth_methods: %w(publickey)
  }


# Fee.where("date_part('day', mescuota) != ?", 1).where.not(mes_cuota: nil).map {|f| f.mescuota = Date.parse("01-#{f.mes_cuota}"); f.save}

# pg_dump enfermera_production -h localhost -U enfermera -W > ~/respaldo.dump
# scp  deployer@52.33.58.120:/home/ubuntu/respaldo.dump /Users/Osvaldo/colegiodeenfermeras/respaldo.dump

# require 'csv'
 
# file = "#{Rails.root}/public/data.csv"
 
# schools = School.where(state_code: 'CO').order('name ASC')
 
# CSV.open( file, 'w' ) do |writer|
#   schools.each do |s|
#     writer << [s.name, s.zipcode, s.id]
#   end
# end



# 35.160.119.161 Staging


# set :rails_env, :production
# set :branch, "master"

# server '54.85.56.20',
#   user: 'web',
#   roles: %w{app web db},
#   ssh_options: {
#      keys: %w(~/.ssh/id_rsa),
#      forward_agent: true,
#      auth_methods: %w(publickey)
#   }
