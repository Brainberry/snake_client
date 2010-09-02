# == Schema Information
#
# Table name: pages
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)     not null
#  slug       :string(30)      not null
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_pages_on_slug  (slug)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
