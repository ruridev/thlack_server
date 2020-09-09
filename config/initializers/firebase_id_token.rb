FirebaseIdToken.configure do |config|
  config.project_ids = ['thlack']
  config.redis = Redis.new(host: 'redis')
end