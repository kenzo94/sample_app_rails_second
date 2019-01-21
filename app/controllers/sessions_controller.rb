class SessionsController < ApplicationController
  def new
  end

  def create
    #params ist eine methode von rails
    user = User.find_by(email: params[:session][:email].downcase)

    #(true && true) == true wenn ein User mit der Email in der Datenbank gefunden wird
    if user && user.authenticate(params[:session][:password])
      #einloggen und redirect zum show page
      #       if boolean?
      #         var = foo
      #       else
      #         var = bar
      #       end
      #     becomes
      #
      #  var = boolean? ? foo : bar
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    else
      #show error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def edit
   @user = User.find(params[:id])
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
