class Api::V1::BaseController < ActionController::Base
  respond_to :json, :xml

  before_action :authenticate_user!
  before_filter :check_rate_limit

  private

 def check_rate_limit
   if current_user.request_count > 10
     error = { :error => "Rate limit exceeded." }
     respond_with(error, :status => 403)
     @user = current_user
   else
     current_user.increment!(:request_count)
   end
 end

end
