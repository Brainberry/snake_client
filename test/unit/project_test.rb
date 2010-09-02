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

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
