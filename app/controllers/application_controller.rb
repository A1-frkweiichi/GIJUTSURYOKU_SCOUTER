class ApplicationController < ActionController::Base
  before_action :update_contributions, if: :user_signed_in?

  def after_sign_in_path_for(resource)
    users_show_path
  end

  private

  def update_contributions
    result = GitHubAPI::Client.query(GithubQueries::ContributionQuery, variables: { username: current_user.name })
    if result.data
      contributions = result.data.user.contributions_collection.contribution_calendar
    end
  end
end
