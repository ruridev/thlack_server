class ApplicationController < ActionController::API
  attr_accessor :current_account, :current_user

  def account_only
    (authenticate_token && account.present?) || render_unauthorized
  end

  def user_only
    (authenticate_token && current_user.present?) || render_unauthorized
  end

  def authenticate_token
    #authenticate_with_http_token do |token, options|
      token = Firebase::Api.verify('application token')
      if token.present?
        account = Account.find_by(identifier: token['user_id'])
        return unless account

        self.current_account = account
      else
        decoded_token = JWT.decode(token, 'MY-SECRET', true, { algorithm: 'HS256' })
        self.current_user = User.find(decoded_token.first['user_id'])
      end
    #end
  end

  def render_unauthorized
    obj = { message: 'Unauthorized token' }
    render json: obj, status: :unauthorized
  end
end