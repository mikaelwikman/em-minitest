$: << 'lib'

require 'bundler/setup'
require 'shoulda'
require 'test/unit'
require 'em-minitest'

class EmMinitestTest < Test::Unit::TestCase

  context 'run inside reactor and in its own fiber' do

    setup do
      @count = 0
      fiber = Fiber.current
      EventMachine.add_timer(0.1) do
        fiber.resume
      end

      Fiber.yield

      @count += 1
    end

    should 'run two tests without problem' do
      fiber = Fiber.current
      EventMachine.add_timer(0.1) do
        fiber.resume
      end

      Fiber.yield

      @count += 1

      assert_equal 2, @count
    end
  end
end
