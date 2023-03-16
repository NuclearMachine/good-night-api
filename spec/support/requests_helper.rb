module RequestHelpers
  def auth_headers_for(user)
    user.create_new_auth_token
  end
end

RSpec.configure do |config|
  config.include RequestHelpers
end
