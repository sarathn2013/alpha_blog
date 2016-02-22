class UsersController < ApplicationController
   before_action :find_user, only: [:edit, :update, :show]
   before_action :require_same_user, only: [:edit, :update]
   before_action :require_admin, only: [:destroy]


def index
	@users = User.paginate(page: params[:page], per_page: 5)
end

def new
	@user = User.new
end

def create
    @user = User.new(user_params)
    if @user.save
    	session[:user_id] = @user.id
      flash[:success] = "Welcome to alpha blog #{@user.username}"
      redirect_to user_path(@user)

    else
    	render "new"
    end
end

def edit

end

def show
	@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
end

def update
	if @user.update(user_params)
		flash[:success] = "Your account was successfully updated"
		redirect_to articles_path
	else
		render 'edit'
	end
end

def destroy
	@user=User.find(params[:id])
	@user.destroy
	flash[:danger] = "User and all articles created by user have been deleted"
	redirect_to users_path
end
	end


private
 def find_user
 	@user=User.find(params[:id])
 end

 def user_params
 	params.require(:user).permit(:username, :email, :password)
 end

 def require_same_user
	if logged_in? && current_user != @user && !current_user.admin?
		flash[:danger] = "You can edit your own profile only"
		redirect_to edit_user_path(current_user)
	end
end

def require_admin
	if !current_user.admin? and logged_in?
		flash[:danger] = "Only admin can perform this action"
		redirect_to root_path
	end
end

