class RelationfavotweetsController < ApplicationController
    
    # ふぁぼ
    def create
        @micropost = micropost.find(params[:tweet_id])
        current_user.favo(@micropost)
    end
    
    # あんふぁぼ
    def destroy
        @micropost = current_user.relationfavotweets.find(params[:id]).tweet
        current_user.unfavo(@micropost)
    end
end
