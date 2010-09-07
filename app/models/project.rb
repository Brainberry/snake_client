# == Schema Information
#
# Table name: projects
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)     not null
#  notes        :text
#  issues_count :integer(4)      default(0)
#  public_key   :string(25)      not null
#  user_id      :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_projects_on_public_key  (public_key)
#  index_projects_on_user_id     (user_id)
#

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :issues, :dependent => :delete_all
  has_many :members, :dependent => :delete_all
  has_many :users, :through => :members, :source => :user
  
  #has_one :repository, :dependent => :destroy
  #has_many :changesets, :through => :repository
  #validates_associated :repository
  
  validates_presence_of :title
  
  attr_accessible :title, :notes
  
  default_value_for :public_key, 'demo'
  
  after_create :generate_public_key, :create_member
  
  #scope :recently_issues, :include => [:issues], :conditions => ["issues.state = ?", Issue.state(:new)], 
  #                              :order => "issues.updated_at DESC"
  
  def last_error_updated_at
    @last_error_updated_at ||= self.errors.map(&:updated_at).max
    @last_error_updated_at || 1.year.ago
  end
  
  protected
  
    def generate_public_key
      update_attribute(:public_key, ActiveSupport::SecureRandom.hex(12))
    end
    
    def create_member
      self.members.create do |m|
        m.user = self.user
        m.role_type = RoleType.author
      end
    end
end
