Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
end

# OmniAuth.config.on_failure = proc { |env| SessionsController.action(:failure).call(env) }

OmniAuth.config.logger = Rails.logger
