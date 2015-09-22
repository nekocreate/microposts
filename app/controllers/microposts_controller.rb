class MicropostsController < ApplicationController
    # ApplicationControllerにあるlogged_in_userメソッドを実行
    # ログインしている場合はcreateメソッドを実行
    before_action :logged_in_user, only: [:create]
    
    def create
        #render text: micropost_params
        
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
        end
    end
    
    def destroy
        #### 親つぶやきを削除する前に、そのつぶやきをretweetしているつぶやきがあれば全て削除する ここから
        @id = params[:id] # deleteしたときに送られたparamsの中のid(micropostのid)を@idに代入
        if Micropost.find_by_retweetid(@id) #retweetidカラムに@idが存在したら
            Micropost.destroy_all(retweetid: @id) # retweetid の値が @id と一致するレコードを全て削除
        end
        #### 親つぶやきを削除する前に、そのつぶやきをretweetしているつぶやきがあれば全て削除する ここまで
        
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        # request.refefferにリダイレクトするが、
        # リクエストの仕方によってreferrerに値が入ってにない場合はroot_urlにリダイレクトする
        # 下のコメントアウトは後ほど取り除く。
        redirect_to request.referrer || root_url
    end

    def retweet
    	@micropost = current_user.microposts.build(micropost_params)
    
    	if @micropost.save
            flash[:success] = "Retweet成功"
            redirect_to root_url
    	else
    		flash[:error] = "Retweet失敗"
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            render 'static_pages/home'
    	end
    end



    private
    
    def micropost_params
        # 投稿本文content と 画像imageを指定 ついでにimage_chachも指定
        params.require(:micropost).permit(:content, :image, :image_cache, :retweetid)
    end
end
