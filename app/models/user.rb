class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :uservotes      

  #********************************************************
 #Begin roles
  ROLES = %w[observer member regional_admin national_admin finance admin web]

  scope :with_role, -> role { where('roles_mask & ? > 0', 2**ROLES.index(role.to_s)) }
  
  def self.get_roles_mask(roles)
    roles = roles.map{|r| r.to_s}
    (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles=(roles)
    roles = roles.map {|r| r.to_s}
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r)}.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def s_roles
    roles.join(', ').humanize
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def role?(role)
    roles.include? role.to_s
  end

  #retorna true si tiene algunos de los relos del arreglo a_roles
  def roles?(a_roles)
    result = false
    a_roles.each{|role|
      result ||= role?(role)
    }
    return result
  end

  def rol
    self.roles_mask
  end

  ## End ROLES 

  def vow?(vote_id)
    user_vow = UserVote.where(vote_id: vote_id, user_id: self.id).first
    user_vow.present?
  end

  def user_vote(vote_id)
    user_vote = UserVote.where(vote_id: vote_id, user_id: self.id).first
    vow = Vow.find_by_token(user_vote.token)
    vow.id
  end

  def allow_to_vote?(vote_id)
    user_allow_vote = UserAlowVote.where(vote_id: vote_id, user_id: self.id).first
    user_allow_vote.present?
  end

  def person
    Person.find_by_rut(self.rut) || nil
  end
  def office
    p = Person.find_by_rut(self.rut)
    p.office || nil
  end
end
