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
  
  #acts_as_enum :state, [:new, :incomplete, :resolved, :verified]
  #acts_as_enum :level, [:default, :warn, :fatal]
  
  before_create :make_public_key
  
  default_scope :order => "updated_at DESC"
  scope :by_state, lambda { |st| { :conditions => ["state = ?", self.state(st.to_sym)] } }
  #scope :recently, :conditions => ["state = ?", self.state(:new)]
  
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
  
  private
    
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
