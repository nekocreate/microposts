class MicropostsController < ApplicationController
    # ApplicationControllerにあるlogged_in_userメソッドを実行
    # ログインしている場合はcreateメソッドを実行
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        # request.refefferにリダイレクトするが、
        # リクエストの仕方によってreferrerに値が入ってにない場合はroot_urlにリダイレクトする
        redirect_to request.referrer || root_url
    end


def retweet
    
    #micropost. = Micropost.find_by_id(params[:id]).attributes
    #render text: params[:id]
    #render text: @micropost.attributes

	#retweetmicropost = Micropost.find_by_id(38).content
	@micropost = current_user.microposts.build(micropost_params)
	#@retweet = Micropost.find_by_id(id: params[:id])
	#render text: @micropost.inspect
	

	#render text: @retweet.inspect
	#@micropost = current_user.microposts.build(
	#    user_id: @retweet.user_id,
	 #   id: @retweet.id, content: @retweet.content,
	 #   image: @retweet.image, created_at: @retweet.created_at, updated_at: @retweet.updated_at
	 #   )
	#render text: @micropost.inspect
	if @micropost.save
        flash[:success] = "Retweet成功"
        redirect_to root_url

	else

		flash[:error] = "Retweet error!"
	end
end




    private
    
    def micropost_params
        # 投稿本文content と 画像imageを指定 ついでにimage_chachも指定
        params.require(:micropost).permit(:content, :image, :image_cache, :retweetid)
    end
end
