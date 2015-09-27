class Micropost < ActiveRecord::Base
  belongs_to :user # belongs_to関連付けで指定するモデル名は必ず「単数形」
  validates :user_id, presence: true
  
  validates :content, presence: true, length: { maximum: 140 }, if: :no_image?, on: :create # imageがないときだけこのバリデーションを適用
  validates :content, length: { maximum: 140 }, if: :aru_image?, on: :create # imageがあるときだけこのバリデーションを適用
  
  def no_image? # はじめは、 image? と書いていたが、読みやすく！とご指摘を受け no_image? と修正した。
    image.blank? # 中身が空か、または入れものそのものが存在しないときの判定
  end
  
  def aru_image?
    image.present?
  end
  
  # carrierwave
  mount_uploader :image, ImageUploader


  ### つぶやきをふぁぼされているリレーション関係の実装 ここから
  has_many :favoing_microposts, class_name: "Relationfavotweet",
                                       foreign_key: "tweet_id",
                                       dependent:  :destroy
  
  has_many :favoing_relationfavotweets, through: :favoing_microposts, source: :favoer
  ### つぶやきをふぁぼされているリレーション関係の実装 まで

  has_many :micropost, foreign_key: "retweetid", dependent: :destroy

end
