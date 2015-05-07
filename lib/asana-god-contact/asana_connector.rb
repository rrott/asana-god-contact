require 'asana-god-contact/stats'
require 'asana-god-contact/config'
require 'asana-god-contact/logger'
require 'net/https'
require 'json'
require 'god'

module AsanaGodContact
  class Connector
    def initialize(options)
      AsanaGodContact::Config::PARAMS.each do |param|
        raise "Required option #{param} not set." unless options[param]
      end

      @options = options
      @uri     = URI.parse(AsanaGodContact::Config::ASANA_URL)
    end

    def create_task
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      res = http.start { |http| http.request(request_params) }

      AsanaGodContact::Logger.responce_message JSON.parse(res.body)
    end

    private
    def request_params
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
  end
end
