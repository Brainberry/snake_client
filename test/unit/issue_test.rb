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

require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
