# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
APP_ID = '1'
APP_SECRET = '123456'

CUSTOM_PROVIDER_URL = 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :login, APP_ID, APP_SECRET
  provider :register, APP_ID, APP_SECRET
end
