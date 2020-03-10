# Provide authentication credentials
Octokit.configure do |c|
  c.bearer_token = "e105c07fd1eb1d6de85fdac12e7294814b263320"
  c.client_id = Rails.application.secrets.github_username
  c.password = Rails.application.secrets.github_password || ""
end

# For smallish resource lists, Octokit provides auto pagination. When this is enabled,
# calls for paginated resources will fetch and concatenate the results from every page
# into a single array
Octokit.auto_paginate = true
