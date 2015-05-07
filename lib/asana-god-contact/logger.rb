module AsanaGodContact
  class Logger
    def self.responce_message(body)
      if body['errors'] then
        applog(nil, :error, "Asana returned an error: #{body['errors'][0]['message']}")
      else
        applog(nil, :info, "Created Asana task with id: #{body['data']['id']} for user #{body['data']['assignee']['name']}")
      end
    end
  end
end