require 'octokit'
require 'fileutils'
require 'dotenv/load'
require 'open-uri'

# Check if the required command-line arguments are provided
if ARGV.length < 1
  puts "Usage: ruby archive_repo.rb <owner/repo> [branch]"
  exit
end

# Get the repository and branch from the command-line arguments
repo = ARGV[0]
branch = ARGV[1] || nil

# Load the personal access token from an environment variable
access_token = ENV['PAT']
if access_token.nil? || access_token.empty?
  puts "Please set the PAT environment variable."
  exit
end

# Initialize the Octokit client
client = Octokit::Client.new(access_token: access_token)

begin
  # Get the repository details
  repo_details = client.repository(repo)

  # Use the default branch if none is specified
  branch ||= repo_details.default_branch

  # Create the archive
  archive_link = client.archive_link(repo, { ref: branch, format: 'tarball' })

  # Download and save the archive locally
  archive_path = "#{repo.gsub('/', '_')}_#{branch}.tar.gz"
  URI.open(archive_link) do |archive|
    File.write(archive_path, archive.read)
  end

  puts "Archive created successfully: #{archive_path}"
rescue Octokit::NotFound
  puts "Repository not found: #{repo}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
