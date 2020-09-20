class ApplicationController < ActionController::API
  attr_accessor :current_account, :current_user

  def account_only
    (authenticate_token && account.present?) || render_unauthorized
  end

  def user_only
    (authenticate_token && current_user.present?) || render_unauthorized
  end

  def authenticate_token
    return unless request.headers['Authorization']

    kind, token = request.headers['Authorization'].split(' ')
    return unless kind == 'Bearer'

    firebase_token = Firebase::Api.verify(token)
    if firebase_token.present?
      account = Account.find_by(identifier: firebase_token['user_id'])
      return unless account

      self.current_account = account
    else
      decoded_token = JWT.decode(token, 'MY-SECRET', true, { algorithm: 'HS256' })
      user = User.find(decoded_token.first['user_id'])
      return unless user

      self.current_account = user.account
      self.current_user = user
    end
  end

  def render_unauthorized
    obj = { message: 'Unauthorized token' }
    render json: obj, status: :unauthorized
  end
end