require 'octokit'
require 'dotenv/load'

if ARGV.length != 2
  puts "Usage: ruby list-pr.rb <GitHub handle> <repository-name>"
  exit
end

handle = ARGV[0]
repo_name = ARGV[1]

client = Octokit::Client.new(:access_token => ENV['PAT'])
repo = "#{handle}/#{repo_name}"
pull_requests = client.pull_requests(repo, state: 'open')

if pull_requests.length == 0
  puts "There are no pull requests."
else
  # Iterate over each pull request and print its number and title
  pull_requests.each do |pr|
    puts "##{pr.number}: #{pr.title}"
  end
end
