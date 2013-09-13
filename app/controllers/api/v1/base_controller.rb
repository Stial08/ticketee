class Api::V1::BaseController < ActionController::Base
  respond_to :json, :xml

  before_action :authenticate_user
  private

  def authenticate_user
    @current_user ||= User.find_by_id!(session[:user_id]) if session[:user_id] != nil
    unless @current_user
      respond_with({:error => "Token is invalid." })
    end
  end
 def current_user
    @current_user 
  end
 end
