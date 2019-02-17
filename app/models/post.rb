class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :likes, dependent: :destroy
  mount_uploader :photo, PhotoUploader
  validates :user_id, presence: true
  validate  :photo_size
  validates :title,   presence: true, length: { maximum: 140 }
  
  # マイクロポストをいいねする
  def like(user_id)
    likes.create(user_id: user_id)
  end

  # マイクロポストのいいねを解除する
  def unlike(user_id)
    likes.find_by(user_id: user_id).destroy
  end
  
  # 現在のユーザーがいいねしているか確認
  def liking?(user_id)
    likes.find_by(user_id: user_id)
  end
  
  private
    # アップロードされた画像のサイズをバリデーションする
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:photo, "写真のサイズは5MB以下にしてください。")
      end
    end
end