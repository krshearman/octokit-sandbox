require 'octokit'
require 'dotenv/load'

# Check if the repository name argument is provided
if ARGV.length != 1
  puts "Usage: ruby create_repo.rb <repository-name>"
  exit
end

# Get the repository name from the command-line argument
new_repo_name = ARGV[0]

# Replace 'your-personal-access-token' with your actual GitHub personal access token
client = Octokit::Client.new(:access_token => ENV['PAT']

# Define the new repository details
new_repo_options = {
  description: 'This is a test repository created using Octokit',
  private: false
}

# Create the new repository
begin
  repo = client.create_repository(new_repo_name, new_repo_options)
  puts "Repository '#{repo.name}' created successfully!"
  puts "Description: #{repo.description}"
  puts "URL: #{repo.html_url}"
rescue Octokit::ClientError => e
  puts "Error creating repository: #{ e.message }"
end

