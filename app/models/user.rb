class User < ApplicationRecord
  attr_accessor :filtered_username, :killer
  
  # user has many posts and comments association
  has_many :posts,    dependent: :destroy

  #hooks
  before_save :downcase_fields
  before_create :hide_name

  #email regex for valid email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #username validation
  validates :username, presence: true, 
                       length: {maximum: 50}, 
                       uniqueness: {case_sensitive: false}
  #email validation
  validates :email, presence: true, 
                    uniqueness: {case_sensitive: false}, 
                    format: {with: EMAIL_REGEX},
                    length: {maximum: 255}

  has_secure_password

  # validates password
  validates :password, presence: true,
                       length: {minimum: 6}

  
  #/// CLASS METHODS ////#

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_hidden_name
    letters = ('a'..'z').to_a
    numbers = (0..9).to_a
    [*letters, *numbers].shuffle[0, 7].join
  end  

  private
  
      def downcase_fields
        self.email.downcase!
        self.username.downcase!
      end

      def hide_name
        self.hidden_name = User.new_hidden_name
      end

      
end
