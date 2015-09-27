class MicropostsController < ApplicationController
    # ApplicationControllerにあるlogged_in_userメソッドを実行
    # ログインしている場合はcreateメソッドを実行
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "投稿しました"
            redirect_to root_url
        else
            # render text: @micropost.errors.inspect ##, @messages={:content=>["は3文字以上で入力してください"]}>
            #@micropost_errors = @micropost.errors # なぜかバリデーションエラーの内容がテンプレートまで渡らないのでここで定義した
            @user = current_user
            flash[:success] = "投稿に失敗しました"
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
            render 'static_pages/home'

        end
    end
    
    def destroy
        #### 以下のコードは、has_many dependent destroyを記述しない場合の方法ですが、こういう方法もあると言うことで、消さずに残しておきたい。
        #### 親つぶやきを削除する前に、そのつぶやきをretweetしているつぶやきがあれば全て削除する ここから
        #@id = params[:id] # deleteしたときに送られたparamsの中のid(micropostのid)を@idに代入
        #if Micropost.find_by_retweetid(@id) #retweetidカラムに@idが存在したら
        #    Micropost.destroy_all(retweetid: @id) # retweetid の値が @id と一致するレコードを全て削除
        #end
        #### 親つぶやきを削除する前に、そのつぶやきをretweetしているつぶやきがあれば全て削除する ここまで
        
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "投稿を削除しました"
        
        if request.referrer.include?("/tweet") # request.referrerに/tweetが含まれていた場合はrequest.referrerはもう存在しないのでroot_pathへリダイレクトする
            redirect_to root_path
        else
            # request.refefferにリダイレクトするが、
            # リクエストの仕方によってreferrerに値が入ってにない場合はroot_urlにリダイレクトする
            # 下のコメントアウトは後ほど取り除く。
            redirect_to request.referrer || root_url
        end
    end

    def retweet
    	@micropost = current_user.microposts.build(micropost_params)
    	if @micropost.save(validate: false) # retweetアクションのみバリデーションを行いたくない場合、@micropost.saveの引数にvalidate: false を指定
            if nil != record = Micropost.where(id: params[:micropost][:retweetid]).first # retweetの親レコードを取得
                oya_image = record.image # imageの値を取得
                if oya_image.present? # 親レコードにimageがあれば
                    record = Micropost.where(id: Micropost.last.id).first # 最後のレコード(直前に投稿されたレコード)にimageを強制的に入れる
                    record.image = oya_image # imageを入れる
                    record.save!
                end
            end
            flash[:success] = "Retweet成功"
            redirect_to root_url
    	else
    	    @user = current_user
    		flash[:error] = "Retweet失敗"
            #@feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
            render 'static_pages/home'
    	end
    end
    
    #def tweet
    #    @micropost = Micropost.find(params[:id])
    #    #@micropost = current_user.microposts.build if logged_in?
    #end

    private
    
    def micropost_params
        # 投稿本文content と 画像imageを指定 ついでにimage_chachも指定
        params.require(:micropost).permit(:content, :image, :image_cache, :retweetid)
    end
end
