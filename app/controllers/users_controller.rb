class UsersController < ApplicationController
  def new
    @user = User.new
    respond_with(Project.for(current_user).all)
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      flash[:notice] = "You have signed up successfully."
      redirect_to projects_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

end
