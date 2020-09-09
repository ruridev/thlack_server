GraphiQL::Rails.config.headers['Authorization'] = -> (context) {
  context.request.env['Authorization']
}