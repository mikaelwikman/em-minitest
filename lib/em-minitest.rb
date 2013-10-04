require 'eventmachine'

# Monkey patch MiniTest to use EM::Synchrony
if defined? MiniTest::Unit
  class MiniTest::Unit
    alias_method :run_alias, :run

    def run(args = [])
      result = nil
      EM.synchrony do
        result = run_alias args
        EM.stop
      end

      result
    end
  end
end

