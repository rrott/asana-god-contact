require 'spec_helper'
require 'god'
require 'asana-god-contact'
require 'asana-god-contact/asana_connector'

class TestAsana < Minitest::Test
  def setup
    @asana = God::Contacts::Asana.new
  end

  def test_exists
    God::Contacts::Asana
  end

  def test_notify
    @asana.api_key      = "tes_api_keyt"
    @asana.workspace_id = "test_workspace"
    @asana.assignee     = "test_assagnee"
    @asana.projects     = "test_projects"
    @asana.folowers     = "test_followers"

    time = Time.now
    body = "[#{time.strftime('%H:%M:%S')}] host - msg"

    #AsanaGodContact::Connector.expects(:create_task).returns("blah")
    #assert_equal "notified asana: test_workspace, test_assagnee, project", @asana.info
    #Marshmallow::Connection.any_instance.expects(:speak).with('test_workspace', body)
    #@asana.notify('msg', time, 'prio', 'cat', 'host')

      mock = MiniTest::Mock.new
      mock.expect(:call, 'create_task')
      AsanaGodContact::Connector.stub(:create_task, mock) do
        @asana.notify("Test", Time.now, "Test", "Test", "")
      end
      mock.verify

  end
end