require 'net/http'
require 'json'

class UsersController < ApplicationController
  def show
    user_info = github_client.user(current_user.name)

    @total_contributions = fetch_contributions_count(current_user.name)
    @contributions_this_month = fetch_contributions_count(current_user.name, 'this_month')
    @contributions_this_week = fetch_contributions_count(current_user.name, 'this_week')
  end

  private

  def github_client
    Octokit::Client.new(access_token: current_user.github_token)
  end

  def fetch_contributions_count(username, period = 'all')
    # GraphQL query to fetch contribution calendar
    query = %{
      user(login: "#{username}") {
        contributionsCollection(from: "#{start_date(period)}", to: "#{end_date(period)}") {
          contributionCalendar {
            totalContributions
          }
        }
      }
    }

    headers = {
      "Authorization" => "Bearer #{current_user.github_token}",
      "Content-Type" => "application/json"
    }

    uri = URI('https://api.github.com/graphql')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = { query: query }.to_json

    response = http.request(request)
    result = JSON.parse(response.body)

    # 応答の内容をログに出力
    Rails.logger.info("GitHub GraphQL Response: #{result.inspect}")

    # 応答の内容が期待される形式であるかを確認
    if result["data"] && result["data"]["user"] && result["data"]["user"]["contributionsCollection"] && result["data"]["user"]["contributionsCollection"]["contributionCalendar"]
      return result["data"]["user"]["contributionsCollection"]["contributionCalendar"]["totalContributions"]
    else
      # 応答が期待される形式でない場合、エラーメッセージをログに出力
      Rails.logger.error("Unexpected GitHub GraphQL Response Format")
      return 0 # または適切なデフォルト値
    end
  end

  def start_date(period)
    case period
    when 'all'
      # Assuming you want data from the beginning of the user's GitHub history
      '2008-01-01'
    when 'this_month'
      Date.today.beginning_of_month.to_s
    when 'this_week'
      Date.today.beginning_of_week.to_s
    end
  end

  def end_date(period)
    case period
    when 'all'
      Date.today.to_s
    when 'this_month', 'this_week'
      Date.today.end_of_day.to_s
    end
  end
end
