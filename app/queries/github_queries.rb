module GithubQueries
  ContributionQuery = GitHubAPI::Client.parse <<-GRAPHQL
    query($username: String!) {
      user(login: $username) {
        contributionsCollection {
          contributionCalendar {
            totalContributions
          }
        }
      }
    }
  GRAPHQL
end
