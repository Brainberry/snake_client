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

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
