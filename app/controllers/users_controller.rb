class UsersController < ApplicationController
  def show
    client = Octokit::Client.new(access_token: current_user.github_token)
    user_info = client.user(current_user.name)

    @total_contributions = user_info.public_repos
    # @contributions_this_month =
    # @contributions_this_week =
  end
end
