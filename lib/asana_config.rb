module AsanaConfig
  API_VERSION  = '1.0'
  ASANA_URL    = "https://app.asana.com/api/#{API_VERSION}/tasks"
  PARAMS       = [:api_key, :workspace_id ,:assignee, :projects, :folowers]
end
#AsanaConfig::ASANA_URL
#AsanaConfig::PARAMS