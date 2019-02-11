class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :photo, PhotoUploader
  validates :user_id, presence: true
  # validates :photo,   presence: true
  validate  :photo_size
  validates :title,   presence: true, length: { maximum: 140 }
  
  private
    # アップロードされた画像のサイズをバリデーションする
    def photo_size
      if photo.size > 5.megabytes
        errors.add(:photo, "写真のサイズは5MB以下にしてください。")
      end
    end
end