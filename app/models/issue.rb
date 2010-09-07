# == Schema Information
#
# Table name: issues
#
#  id              :integer(4)      not null, primary key
#  message         :string(255)
#  namespace       :string(255)
#  url             :string(255)
#  controller_name :string(255)
#  action_name     :string(255)
#  host            :string(255)
#  environment     :text
#  request         :text
#  session         :text
#  backtrace       :text
#  state           :integer(1)      default(0)
#  comments_count  :integer(4)      default(0)
#  copies_count    :integer(4)      default(0)
#  parent_id       :integer(4)
#  project_id      :integer(4)      not null
#  public_key      :string(40)      not null
#  member_id       :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_issues_on_project_id_and_public_key  (project_id,public_key)
#  index_issues_on_state                      (state)
#

class Issue < ActiveRecord::Base
  belongs_to :project, :counter_cache => true
  belongs_to :member
  has_many :comments, :as => :commentable, :dependent => :delete_all
  
  before_create :make_public_key
  
  default_scope :order => "updated_at DESC"
  scope :with_state, lambda { |value| where(:state => self.state_value(value)) }
  
  state_machine :state, :initial => :pending do
    
    event :process do
	    transition [:pending] => :verified
    end
    
    event :fix do
	    transition [:pending, :verified, :incomplete] => :closed
    end
    
    state :pending,    :value => 0
    state :verified,   :value => 1
    state :closed,     :value => 2
    state :incomplete, :value => 3
  end
  
  def title
    @title ||= "A #{namespace} occurred in #{controller_name}##{action_name}"
    @title
  end
    
  def trace
    @trace ||= Backtrace.parse(backtrace)
    @trace
  end
  
  def env
    @env ||= parse_env(environment)
    @env
  end
  
  def public_key_params
    [ namespace, url, controller_name, action_name ].compact
  end
  
  def self.state(name)
	  state_machine.states.detect { |state| state.name == name }
	end
	
	def self.state_value(name)
	  object = self.state(name)
	  object.nil? ? nil : object.value
	end
  
  protected
    
    def parse_env(value)
      return {} if value.blank?
      
      options = {}
      value.split(/\|/).each do |line|
        t = line.split(':')
        options[t.shift.to_s.strip] = t.join.to_s.strip
      end
      
      options
    end
    
    def make_public_key
      self.created_at ||= Time.now
      self.public_key = Digest::SHA1.hexdigest(public_key_params.join('--'))
    end
end
