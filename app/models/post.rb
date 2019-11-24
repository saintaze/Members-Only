class Post < ApplicationRecord
  belongs_to :user

  # user_id validation
  validates :user_id, presence: true

  # title validation
  validates :title, presence: true, 
                    length: {maximum: 255},
                    uniqueness: {case_sensitive: false}
  
  # body validation
  validates :body, presence: true
  
  default_scope -> { order(created_at: :desc) }

  def self.search(pattern)
    if pattern.blank?
      Post.all
    else
      posts = Post.all.where("title ilike lower(?) or body like lower(?)", "%#{pattern.downcase}%", "%#{pattern.downcase}%")
      posts.count == 0 ?  Post.all : posts
    end
  end

end

