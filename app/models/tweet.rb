class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :user, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :title, allow_blank: true, length: { in: 0..255 }
  validates :url, allow_blank: true, length: { in: 0..65535 }
  validates :image, allow_blank: true, length: { in: 0..65535 }
  validates :description, allow_blank: true, length: { in: 0..65535 }

  default_scope -> { order(created_at: :desc) }

  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
end
