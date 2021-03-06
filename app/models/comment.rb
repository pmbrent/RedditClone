class Comment < ActiveRecord::Base

  validates :user_id, :post_id, :content, presence: true
  validate  :ensure_user_exists, :ensure_post_exists

  belongs_to :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :post

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id

  def top_level_parent
    return self if parent_comment_id == nil
    Comment.find(self.parent_comment_id).top_level_parent
  end

  def ensure_user_exists
    unless User.find(user_id)
      comment.errors[:user_id] << "User id must be valid!"
    end
  end

  def ensure_post_exists
    unless Post.find(post_id)
      comment.errors[:post_id] << "Post id must be valid!"
    end
  end

end
