class UsersController < ApplicationController
  #users/index
  def index
  	@users = User.all
  	#puts "#{@users.inspect}"
  end

  #users/123
  def show
  	@user = User.find(params[:id])
  end

  #users/new
  def new
  	@user = User.new
  end

  #users/
  def create
  	params_filtered = params.require(:user).permit(:name, :email, :password, :avatar)
  	#params_filtered = {name: "michel", email:"michel@gmai.com", password:"2131312"}
  	@user = User.new(params_filtered)
  	if @user.save
  		redirect_to users_path
  	else
  		render 'new'
  	end
  end

  #users/:id
  def update
    params_filtered = params.require(:user).permit(:name, :email, :password)
    #params_filtered = {name: "michel", email:"michel@gmai.com", password:"2131312"}
    @user = User.find(params[:id])
    if @user.update(params_filtered)
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def login
    @user = User.new
  end

  def do_login
    params_filtered = params.require(:user).permit(:email, :password)
    @user = User.new(params_filtered)
    if @user_logged = @user.login
      session[:user_id] = @user_logged.id
      redirect_to products_path, notice: "Bienvenido #{@user.name}"
    else
      flash[:error] = 'Ocurrio un error logeando al usuario'
      render 'login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_users_path
  end

end
