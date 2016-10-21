set :ip, "54.186.192.122"
# set :ip, "35.160.119.161" 
set :rails_env, 'production'
server "#{ip}", :web, :app, :db, primary: true,
  ssh_options: {
     keys: %w(/Users/osvaldo/.ssh/id_rsa),
     forward_agent: true,
     auth_methods: %w(publickey)
  }



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
