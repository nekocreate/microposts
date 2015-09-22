class Micropost < ActiveRecord::Base
  belongs_to :user # belongs_to関連付けで指定するモデル名は必ず「単数形」
  validates :user_id, presence: true
  
  # contentなしimageのみの投稿を許可してみたが、retweetの際contentがカラだとバリデーションに引っかかるようになった。
  # だから、原則としてcontentの入力は必須とすることとした。
  # validates :content, presence: true, length: { maximum: 140 }, if: :no_image? # imageがない場合のみバリデーションをスキップ
  validates :content, presence: true, length: { maximum: 140 }
  
  def no_image? # はじめは、 image? と書いていたが、読みやすく！とご指摘を受け no_image? と修正した。
    image.blank? # 中身が空か、または入れものそのものが存在しないときの判定
  end
  
  # carrierwave
  mount_uploader :image, ImageUploader
end
