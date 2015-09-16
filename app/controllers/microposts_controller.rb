class MicropostsController < ApplicationController
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
    
    private
    def micropost_params
        # 投稿本文だけという意味？
        params.require(:micropost).permit(:content)
    end
end
