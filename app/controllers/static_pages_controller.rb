class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
      # @micropost = Micropost.new(user_id: current_user.id) と同じだが、
      # current_userのhas_many :micropostsで生成されるbuildメソッドを使用することで
      # user_idが紐付いたデータを生成できるcurrent_user.microposts.buildを使用すること！
      
      # routesの設定で、　/ にアクセスした場合、static_pagesのhomeアクションが実行され、
      # viewは、static_pages/home.html.erbを返すが、その時、パーシャルの部分テンプレートも読み込まれる
  end
end
