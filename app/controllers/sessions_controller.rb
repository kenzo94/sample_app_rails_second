class SessionsController < ApplicationController
  def new
  end

  def create
    #params ist eine methode von rails
    user = User.find_by(email: params[:session][:email].downcase)

    #(true && true) == true wenn ein User mit der Email in der Datenbank gefunden wird
    if user && user.authenticate(params[:session][:password])
      #einloggen und redirect zum show page
      log_in user
      redirect_to user_url(user)
    else
      #show error message
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'

    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
