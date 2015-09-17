class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User" # Userモデルを指定
  belongs_to :followed, class_name: "User"
  ######### リレーションの関連づけメモ ##########
  # Railsは外部キーをそれに対応するシンボルから推測する。
  # 関連 → モデル → Relationshipで持つ参照
  # belongs_to :follower → Follower → follower_id
  # FollowerモデルもFollowedモデルも存在しないので、明示的にクラス名class_nameとしてUserモデルを指定する。
end
