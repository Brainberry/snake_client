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

class Comment < ActiveRecord::Base
  attr_protected :user_id
  
  belongs_to :commentable, :polymorphic => true, :counter_cache=>:comments_count
  belongs_to :user
 	
 	validates_presence_of :content, :user_email, :user_name
 	
  validates_length_of :user_name,     :maximum => 100
 	validates_length_of :user_email,    :within => 6..100 #r@a.wk
  validates_inclusion_of :commentable_type, :in => %w( Post Project Issue )
  
 	before_validation :make_user
  #after_create :make_email
 	
 	#apply_simple_captcha :message=>I18n.t('label.captcha_error')
 	
 	named_scope :siblings_for, lambda { |*args| { 
 	            :conditions=>["commentable_id = ? AND commentable_type = ?", args.first.commentable_id, args.first.commentable_type], 
 	            :order=>"created_at DESC" } }
 	            
 	named_scope :follows, :conditions=>{:is_follow=>true} 
 	
 	white_list :only=>[:content, :user_name], :profile=>:mini
 	auto_html_for :content do
    html_escape
    image
    youtube :width => 500, :height => 300
    vimeo :width => 500, :height => 300
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
  
  def is_owner?(author)
    author == self.user && self.created_at < 10.minutes.ago
  end
    
  def comments_count
    @comments_count ||= self.class.count(:conditions=>["commentable_id = ? AND commentable_type = ?", self.commentable_id, self.commentable_type])
    @comments_count
  end
  
  def siblings
    @siblings ||= self.class.siblings_for(self)
    @siblings
  end
  
  private
  
    def make_user
    	unless self.user.nil?
      	self.user_email = self.user.email
      	self.user_name = self.user.name
    	end
    end
    
    def make_email
      # Send email to admins
      UserMailer.deliver_comment(self, User.roles(:admin).map(&:email))
      
      # Send email to follows users
      emails = self.class.siblings_for(self).follows.find(:all, :select=>"user_email", :group=>"user_email").map(&:user_email)
      emails = emails.uniq - [self.user_email]
      emails.each { |email| UserMailer.deliver_comment(self, [email]) }
    end
end
