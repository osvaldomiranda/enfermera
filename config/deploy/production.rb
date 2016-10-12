set :ip, "45.79.158.208"
server "#{ip}", :web, :app, :db, primary: true
set :rails_env, 'production'

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
