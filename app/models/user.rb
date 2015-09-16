class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :profile, presence: true, length: { maximum: 255 }
    validates :password, length: { minimum: 6 } , on: :create
    validates :password, length: { minimum: 6 } , on: :update, allow_blank: true
    has_many :microposts # has_many関連付けを宣言する場合、相手のモデル名は「複数形」
end
