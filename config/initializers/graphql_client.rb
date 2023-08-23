require "graphql/client"
require "graphql/client/http"

module GitHubAPI
  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      { "Authorization": "Bearer #{ENV['GITHUB_ACCESS_TOKEN']}" }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTP)
  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
