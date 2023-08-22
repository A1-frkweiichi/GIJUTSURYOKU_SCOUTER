class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth = request.env["omniauth.auth"]
    @user = User.find_for_github_oauth(auth, current_user)

    if @user.persisted?
      # GitHubのコントリビューション数を取得
      update_github_contributions(@user, auth)

      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Github") if is_navigational_format?
    else
      session["devise.github_data"] = auth
      redirect_to new_user_registration_url
    end
  end

  private

  def update_github_contributions(user, auth)
    require 'octokit'
    client = Octokit::Client.new(access_token: user.github_token)
    github_username = auth.info.nickname
    github_user = client.user(github_username)

    # コントリビューション数の取得（例として、公開リポジトリの数を取得）
    contributions = github_user.public_repos

    # データベースに保存
    user.update(contributions: contributions)
  end
end
