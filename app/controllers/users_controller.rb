class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # @users = User.all だと全てのuserのものが入ってしまうのでだめ。
    
    @microposts = @user.microposts # ユーザーに紐付いたマイクロポストを代入
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


  
  private
  
  def user_params
    # params.require(:user).permit(:name, :email, :password, :password_confirmation)
    params.require(:user).permit(:name, :email, :area, :profile, :password, :password_confirmation)
  end
end