require 'octokit'
require 'dotenv/load'

if ARGV.length != 2
  puts "Usage: ruby create-issue.rb <GitHub handle> <repository-name>"
  exit
end

handle = ARGV[0]
repo_name = ARGV[1]

client = Octokit::Client.new(:access_token => ENV['PAT'])
repo = "#{handle}/#{repo_name}"
issue_title = 'Another New Issue Title'
issue_body = 'Description of the NEW issue.'

issue = client.create_issue(repo, issue_title, issue_body)
puts "Created issue #{issue.number}: #{issue.title}"
