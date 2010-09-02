# == Schema Information
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  login                :string(50)      not null
#  name                 :string(150)
#  role_type_id         :integer(1)
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  failed_attempts      :integer(4)      default(0)
#  locked_at            :datetime
#  identifier           :string(150)
#  created_at           :datetime
#  updated_at           :datetime
#
# Indexes
#
#  index_users_on_login                 (login) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_role_type_id          (role_type_id)
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :registerable
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  validates_presence_of :name
  before_validation :make_login
	
	enumerated_attribute :role_type
	
	has_many :projects, :dependent => :nullify
	has_many :members, :dependent => :delete_all
	has_many :applications, :through => :members, :source => :project
	#has_many :issues, :through => :applications, :source => :issues
	has_many :comments, :dependent => :nullify
	has_gravatar :size => 50
	
	scope :activated, :conditions=>"users.activated_at IS NOT NULL", :order=>"login"
	scope :active, :conditions=>{:state => 'active'}
	
	def issues(options = {})
	  options.update :conditions => ["project_id IN (SELECT project_id FROM members 
	                                  WHERE user_id = ? AND state = ?)", self.id, 'active']
	  
	  Issue.scoped options
	end
	
	def title
		self.name || self.login
	end
	
	def to_param
		"#{self.id}-#{self.login}"
	end
	
	def role?(role_name)
	  
	end
	
  def self.find_for_database_authentication(conditions)
    value = conditions[authentication_keys.first]
    where(["login = :value OR email = :value", { :value => value }]).first
  end
  
  protected
    
    def make_login
	    return if self.email.blank?
	    
    	if self.login.blank?
    		tmp_login = self.email.split(/@/).first
    		tmp_login ||= ActiveSupport::SecureRandom.hex(6)
    		tmp_login = tmp_login.parameterize.downcase.gsub('.', '_')
    		tmp_login = [tmp_login, ActiveSupport::SecureRandom.hex(4)].join('_') unless User.find_by_login(tmp_login).nil?
    		self.login = tmp_login
    	end
    end
end
