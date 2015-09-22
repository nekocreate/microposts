class UsersController < ApplicationController
  # このUserController内の処理を実行する前にまず行うこと！
  before_action :admin_user, only: [:edit, :update]
  
  def show
    
    @user = User.find(params[:id])
    # @users = User.all だと全てのuserのものが入ってしまうのでだめ。
    
    @microposts = @user.microposts # ユーザーに紐付いたマイクロポストを代入
    @micropost = Micropost.new
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # if @user.save
    #  flash[:success] = "Welcome to the Sample App!" # フラッシュメッセージ
    #  # redirect_to @user # 下記と同じ動作をする
    #  # redirect_to user_path(@user)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      session[:user_id] = @user.id # リダイレクト前にセッションを使う方が望ましい
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    # @user = User.find(params[:id]) # アドレスバーのusers/の番号を変更したらRailsが他userの情報を取得してしまう。
    @user = User.find(current_user.id) # 上記を避けるためにcurrent_userのIDを取得するようにする
  end

  def update
    # @user = User.find(params[:id])
    @user = User.find(current_user.id) # current_userのidを使って、ログインしていない他のuserのデータをupdateできないようにする
    if @user.update(user_params)
      # 保存に成功した場合はTopページへリダイレクト
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      # 保存に失敗した場合は、編集画面に戻す
      render 'edit'
    end
  end

  def followings
    begin
      # Userのパラメータ名が:idのものを見つけて@userにいれる。
      @user = User.find(params[:id])
      # 自動的に followings.html.erbが呼ばれる
    rescue
      flash[:danger] = 'そのユーザーは存在しません'
      redirect_to root_path
    end
  end

  def followers
    begin
      # Userのパラメータ名が:idのものを見つけて@userにいれる。
      @user = User.find(params[:id])
      # 自動的に followers.html.erbが呼ばれる
    rescue
      flash[:danger] = 'そのユーザーは存在しません'
      redirect_to root_path
    end
  end

  def index
    # kaminari の設定 1ページにいくつ表示させるかを.par()の引数に
    @users = User.order(":id").page(params[:page]).per(5)
  end
  
  # userの動作検証用
  def test
  end
  

  private
  
  def user_params
    # params.require(:user).permit(:name, :email, :password, :password_confirmation)
    params.require(:user).permit(:name, :email, :area, :profile, :password, :password_confirmation)
  end
  
  
  def admin_user
    @user = User.find(params[:id]) # 現在のURLの:idに一致するユーザーを@userに代入
    redirect_to root_path unless current_user == @user # current_userと@userが別人ならroot_pathにリダイレクト
  end
end
