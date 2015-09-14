class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    # @users = User.all
  

  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!" # フラッシュメッセージ
      redirect_to @user # 下記と同じ動作をする
      # redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  

def edit
  @user = User.find(params[:id])
end


  def update
    @user = User.find(params[:id])
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
