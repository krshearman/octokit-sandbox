require 'octokit'
require 'dotenv/load'

client = Octokit::Client.new(:access_token => ENV['PAT']

# Example: List repositories for a user
repos = client.repositories('')

# Print out the name and description of each repository
repos.each do |repo|
  puts "Name: #{repo.name}"
  puts "Description: #{repo.description}"
  puts "URL: #{repo.html_url}"
  puts "-" * 40
end
