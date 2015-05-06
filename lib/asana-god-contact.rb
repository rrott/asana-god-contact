require "asana-god-contact/version"
require 'asana-god-contact/asana_config'
require 'asana-god-contact/asana_conector'
require 'god/contact'

module God
  module Contacts
    class Asana < God::Contact
      class << self
        attr_accessor :api_key, :workspace_id, :assignee, :projects, :folowers
        attr_accessor :format
      end

      self.format = lambda do |message, time, priority, category, host|
        "[#{time}] #{host} - #{message}"
      end

      def valid?
        valid = true
        AsanaConfig::PARAMS.each do |param|
          valid &= complain("Attribute #{param} must be specified", self) unless arg(param)
        end
        valid
      end

      attr_accessor :api_key, :workspace_id, :assignee, :projects, :folowers

      def notify(message, time, priority, category, host)
        body = Asana.format.call(message, time, priority, category, host)

        connection = AsanaGodContact::Connector.new(
          :api_key      => arg(:api_key),
          :workspace_id => arg(:workspace_id),
          :assignee     => arg(:assignee),
          :projects     => arg(:projects),
          :folowers     => arg(:folowers),
          :message      => body
        )

        connection.create_task

        self.info = "notified asana: #{arg(:workspace_id)}, #{arg(:assignee)}, project #{arg(:project)}"
      rescue Object => e
        applog(nil, :info, "failed to notify asana: #{arg(:workspace_id)}, #{arg(:assignee)}, project #{arg(:project)}")
        applog(nil, :debug, e.backtrace.join("\n"))
      end
    end
  end
end