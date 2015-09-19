class StaticPagesController < ApplicationController
  # routesの設定で、　/ にアクセスした場合、static_pagesのhomeアクションが実行され、
  # viewは、static_pages/home.html.erbを返すが、その時、パーシャルの部分テンプレートも読み込まれる

  def home
    if logged_in?
      @micropost = current_user.microposts.build
        # @micropost = Micropost.new(user_id: current_user.id) と同じだが、
        # current_userのhas_many :micropostsで生成されるbuildメソッドを使用することで
        # user_idが紐付いたデータを生成できるcurrent_user.microposts.buildを使用すること！
      
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
        # order(created_at: :desc) とは、取得した値をcreated_at(投稿日)で並び替える処理
    end
  end
end
