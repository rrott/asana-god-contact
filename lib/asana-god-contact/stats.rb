require 'sys/proctable'
include Sys

module AsanaGodContact
  class Stats
    def self.list
      ProcTable.ps{ |p|
        (@processes ||= "") << "id: #{p.pid} command: #{p.comm} \ncmdline: #{p.cmdline}\n\n"
      }
      @processes.to_s
    end
  end
end
