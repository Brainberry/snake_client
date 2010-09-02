# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  user_name        :string(50)
#  user_email       :string(50)
#  content          :text            default(""), not null
#  content_html     :text
#  user_id          :integer(4)
#  commentable_id   :integer(4)      default(0), not null
#  commentable_type :string(15)      default(""), not null
#  is_follow        :boolean(1)      default(FALSE)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_comments_on_user_id                              (user_id)
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
