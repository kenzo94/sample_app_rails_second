module SessionsHelper
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
  def current_user
    if session[:user_id]
      #User.find_by(id: 3) -> wie in der Datenbank die methode
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end


  # Returns true if the user is logged in, false otherwise.
 def logged_in?
   !current_user.nil?
 end

 # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
end
