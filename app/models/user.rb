class User < ApplicationRecord
  
  # user has many posts and comments association
  has_many :posts,    dependent: :destroy

  #hooks
  before_save :downcase_fields

  #email regex for valid email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #username validation
  validates :username, presence: true, 
                       length: {maximum: 50}, 
                       uniqueness: true
  #email validation
  validates :email, presence: true, 
                    uniqueness: {case_sensitive: false}, 
                    format: {with: EMAIL_REGEX},
                    length: {maximum: 255}
  private
  
      def downcase_fields
        self.email.downcase!
        self.username.downcase!
      end
end
