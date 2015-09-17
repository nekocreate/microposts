class RelationshipsController < ApplicationController
    # ApplicationControllerにあるlogged_in_userメソッドを実行
    before_action :logged_in_user
    
    # フォローを行う
    def create
        # フォローする他のユーザーのIDをパラメータとして受け取り@userに入れる
        @user = User.find(params[:followed_id])
        # 以下は上記と同じ意味？時間があったら検証してみる
        # @user = User.find(params[:relationship][:followed_id])
        
        # @userを引数として、かつcurrent_userとして、Userモデルのfollowメソッドを実行
        current_user.follow(@user)
        
        # フォーム form_for でオプション remote: true が指定されているので、返されるテンプレートはjs(JavaScript)
        # app/views/relationships/create.js.erb が実行される
    end
    
    # アンフォローを行う
    def destroy
        # current_userのfollowing_relationshipsを検索して、他のユーザーをフォローしている場合は@userに入れる
        @user = current_user.following_relationships.find(params[:id]).followed
        
        # @userを引数として、かつcurrent_userとして、Userモデルのunfollowメソッドを実行
        current_user.unfollow(@user)
        
        # フォーム form_for でオプション remote: true が指定されているので、返されるテンプレートはjs(JavaScript)
        # app/views/relationships/destroy.js.erb が実行される
    end
end
