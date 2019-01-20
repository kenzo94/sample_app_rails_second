class UsersController < ApplicationController

  #WIE DIE User.find() methode in der Datenbank , navigiert zu show.html.erb
  def show
      @user = User.find(params[:id])
      #debugger #byebug wird auf der Commandline aufgerufen wenn wir die URL user/1 aufgerufen
                #damit können wir dann mit der Seite interagieren und bugfixen
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
      log_in @user
      #The Rails way to display a temporary message is to use a special method called the flash, which we can treat like a hash.
      # Rails adopts the convention of a :success key for a message indicating a successful result
      flash[:success] = "Welcome to the Sample App!"

      # Handle a successful save. redirect_to @user gleicher code
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

  # wir wollen das der User nur die geforderten Felder gibt
  #This code returns a version of the params hash with only the permitted attribute
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
