class UsersController < ApplicationController
  #before die unteren actions gemacht werden können muss der user eingelog sein
  #damit kann man dann nicht manuell auf path wie /user/edit zugreifen
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  #WIE DIE User.find() methode in der Datenbank , navigiert zu show.html.erb
  def show
      @user = User.find(params[:id])
      #debugger #byebug wird auf der Commandline aufgerufen wenn wir die URL user/1 aufgerufen
                #damit können wir dann mit der Seite interagieren und bugfixen
      @microposts = @user.microposts.paginate(page: params[:page])
    end

  def new
    #debugger mächtiges tool zum debuggen !!
    # User.new navigiert zu new.html.erb
    @user = User.new
  end

  def create
    #das ist wie in der Datenbank User.create(Hash)
    @user = User.new(user_params)
    if @user.save
      #The Rails way to display a temporary message is to use a special method called the flash, which we can treat like a hash.
      # Rails adopts the convention of a :success key for a message indicating a successful result
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
   @user = User.find(params[:id])
 end

 def update
   @user = User.find(params[:id])
   if @user.update_attributes(user_params)
     # Handle a successful update.
     flash[:success] = "Profile updated"
     redirect_to @user
   else
     render 'edit'
   end
 end

 def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
end

  private

  # wir wollen das der User nur die geforderten Felder gibt
  #This code returns a version of the params hash with only the permitted attribute
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters von ganz oben


  # Confirms the correct user.
   def correct_user
     @user = User.find(params[:id])
     # redirect_to(root_url) unless @user == current_user
     #helper methode
     redirect_to(root_url) unless current_user?(@user)
   end

   # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
