class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }, on: :create
    validates :profile, presence: true, length: { maximum: 255 }, on: :update
    validates :area, length: { maximum: 32 }, on: :update

    # carrierwave
    mount_uploader :profileimage, ImageUploader

    # has_many関連付けを宣言する場合、相手のモデル名は「複数形」
    has_many :microposts
    
    ### あるuserがフォローしている人の実装 ここから###
    # class_nameとしてRelationshipモデルを指定
    # 外部キー foreign_key として follower_id を明示的に指定
    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
    # has_many～throughを使い、following_usersはfollowing_relationship経由でデータを取得する
    # sourceパラメータで、folowing_usersはfollowdのidの集合体であることを明示的に指定
    has_many :following_users, through: :following_relationships, source: :followed
    ### あるuserがフォローしている人の実装 ここまで###
    
    ### フォローされている人の実装 ここから ###
    # class_nameとしてRelationshipモデルを指定
    # 外部キー foreign_key として followed_id を明示的に指定
    has_many :follower_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy

    # has_many～throughを使い、follower_usersはfollower_relationships経由でデータを取得する
    # sourceパラメータで、follower_usersはfollowerのidの集合体であることを明示的に指定
    has_many :follower_users, through: :follower_relationships, source: :follower
    ### フォローされている人の実装 ここまで ###
    
    ### つぶやきをふぁぼするリレーション関係の実装 ここから
    has_many :favoing_relationfavotweets, class_name: "Relationfavotweet",
                                         foreign_key: "favoer_id",
                                         dependent:  :destroy
    
    has_many :favoing_microposts, through: :favoing_relationfavotweets, source: :tweet
    ### つぶやきをふぁぼするリレーション関係の実装 ここから    


    # つぶやきをふぁぼる
    def favo(other_micropost)
        favoing_relationfavotweets.create(tweet_id: other_micropost.id)
    end
    
    # つぶやきをあんふぁぼする
    def unfavo(other_micropost)
        favoing_relationfavotweets.find_by(tweet_id: other_micropost.id).destroy
    end
    
    # あるつぶやきをふぁぼしているかどうか？
    def favoing?(other_micropost)
        favoing_microposts.include?(other_micropost)
    end


    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.create(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    # feed_itemsの場合は、Micropostの「user_idと一致するもの」を探して、配列同士を+で要素を足し合わせる。
    # user_idがフォローしているユーザーのつぶやきを取得して配列で返す。
    # 配列同士を +で要素を足し合わせてる。
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end

    # favo_itemsの場合は、Micropostの「idと一致するもの」を探して、配列同士を+で要素を足し合わせる。
    def favo_items
        #@user = User.find_by_id([:id])
        Micropost.where(id: favoing_micropost_ids + [self.id])
    end

end
