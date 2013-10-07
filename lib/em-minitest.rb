require 'eventmachine'
require 'fiber'

# Excerpt from em-synchrony gem, see https://github.com/igrigorik/em-synchrony for credit and license
##

module EventMachine

  # A convenience method for wrapping a given block within
  # a Ruby Fiber such that async operations can be transparently
  # paused and resumed based on IO scheduling.
  # It detects whether EM is running or not.
  def self.synchrony(blk=nil, tail=nil)
    # EM already running.
    if reactor_running?
      if block_given?
        Fiber.new { yield }.resume
      else
        Fiber.new { blk.call }.resume
      end
      tail && add_shutdown_hook(tail)

    # EM not running.
    else
      if block_given?
        run(nil, tail) { Fiber.new { yield }.resume }
      else
        run(Proc.new { Fiber.new { blk.call }.resume }, tail)
      end

    end
  end
end

##
## end excerpt

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

