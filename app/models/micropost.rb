class Micropost < ActiveRecord::Base
  belongs_to :user # belongs_to関連付けで指定するモデル名は必ず「単数形」
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
