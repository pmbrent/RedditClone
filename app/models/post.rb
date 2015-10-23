class Post < ActiveRecord::Base
  validates :title, :sub_id, :user_id, presence: true
  validate :content_or_url
  validate :sub_exists
  validate :user_exists

  belongs_to :sub,
    class_name: 'Sub',
    foreign_key: :sub_id,
    primary_key: :id

  belongs_to :author,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  def content_or_url
    if url.empty? && content.empty?
      self.errors[:content] << "Must provide content or URL"
    end
  end

  def sub_exists
    unless Sub.find(sub_id)
      self.errors[:sub_id] << "Sub id must be valid!"
    end
  end

  def user_exists
    unless User.find(user_id)
      self.errors[:user_id] << "User id must be valid!"
    end
  end

end
