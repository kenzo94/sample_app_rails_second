module SessionsHelper

  # Remembers a user in a persistent session.
   def remember(user)
     user.remember
     cookies.permanent.signed[:user_id] = user.id
     cookies.permanent[:remember_token] = user.remember_token
   end


  # Logs in the given user.

  def log_in(user)
    #session is eine methode von rails
    #zuweisung der userid an die session
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  # wir merken uns den User der eingelog ist mit seiner sessionid
  #@current_user = @current_user || User.find_by(id: session[:user_id])
  #wenn current_user schon einen wert zu gewiesen wurde dann wird die
  #User.find methode nicht benutzt
  # >> @foo
  # => nil
  # >> @foo = @foo || "bar"
  # => "bar"
  # >> @foo = @foo || "baz"
  # => "bar"
  #
  # das sieht nicht gut aus deswegen der untere ansatz
  #   if @current_user.nil?
  #   @current_user = User.find_by(id: session[:user_id])
  # else
  #   @current_user
  # end
  # def current_user
  #   if session[:user_id]
  #     #User.find_by(id: 3) -> wie in der Datenbank die methode
  #     @current_user ||= User.find_by(id: session[:user_id])
  #   end
  # end

  # advanced login
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #raise       # The tests still pass, so this branch is currently untested.
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
 def logged_in?
   !current_user.nil?
 end

 # Forgets a persistent session.
   def forget(user)
     user.forget
     cookies.delete(:user_id)
     cookies.delete(:remember_token)
   end

 # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
