# == Schema Information
#
# Table name: members
#
#  id           :integer(4)      not null, primary key
#  role_type_id :integer(1)      default(0)
#  user_id      :integer(4)      not null
#  project_id   :integer(4)      not null
#  state        :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_members_on_project_id_and_user_id  (project_id,user_id)
#  index_members_on_state                   (state)
#

class Member < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :issues, :dependent => :nullify
  
  enumerated_attribute :role_type
  
  # For invite
  attr_accessor :email
end
