class RelationfavotweetsController < ApplicationController
    
    # ふぁぼ
    def create
        #render text: params
        @micropost = Micropost.find(params[:tweet_id])
        current_user.favo(@micropost)
        #flash[:success] = "つぶやきをふぁぼしました"
        #redirect_to request.referrer || root_url
    end
    
    # あんふぁぼ
    def destroy
        #render text: params
        @micropost = current_user.favoing_relationfavotweets.find(params[:id]).tweet
        current_user.unfavo(@micropost)
        #flash[:success] = "あんふぁぼしました"
        #redirect_to request.referrer || root_url
    end
end
