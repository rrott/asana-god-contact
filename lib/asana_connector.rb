require 'json'
require 'net/https'
require 'asana_config'
require 'stats'

class AsanaConnector
  def initialize(options)
    AsanaConfig::PARAMS.each { |param| raise "Required option #{param} not set." unless options[param] }
    @options = options
    @uri     = URI.parse(AsanaConfig::ASANA_URL)
  end

  def create_task
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    res = http.start { |http| http.request(requester) }
    show_message res
  end

  private
  def requester
    header = {"Content-Type" => "application/json"}
    req = Net::HTTP::Post.new(@uri.path, header)
    req.basic_auth(@options[:api_key], '')
    req.body = request_body
    req
  end

  def request_body
    {
      "data" => {
        "workspace" => @options[:workspace_id],
        "name"      => @options[:message],
        "assignee"  => @options[:assignee],
        "projects"  => @options[:projects],
        "folowers"  => @options[:folowers],
        "notes"     => AsanaGodContact::Stats.list
      }
    }.to_json()
  end

  def time
    (Time.now).strftime('%F %T')
  end

  def show_message(res)
    body = JSON.parse(res.body)
    if body['errors'] then
      puts "I [#{time}]  INFO: Asana returned an error: #{body['errors'][0]['message']}"
    else
      puts "I [#{time}]  INFO: Created Asana task with id: #{body['data']['id']} for user #{body['data']['assignee']['name']}"
    end
  end
end
