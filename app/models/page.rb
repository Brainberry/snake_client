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

class Page < ActiveRecord::Base
  validates_presence_of :title, :content
  
  #belongs_to :structure
  
  def content_without_html
    return nil if self.content.blank?
    self.content.no_html
  end
end
