class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #Helper ist jetzt auch in controllers verfügbar 
  include SessionsHelper
end
