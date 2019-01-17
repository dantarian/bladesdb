require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "game with no end date counts as 1 towards P:M ratio" do
    game = Game.new
    game.start_date = Date.today
    game.end_date = nil

    assert_equal(1, game.pm_ratio_value)
  end

  test "game with equal start and end dates counts as 1 towards P:M ratio" do
    game = Game.new
    game.start_date = Date.today
    game.end_date = Date.today

    assert_equal(1, game.pm_ratio_value)
  end

  test "game with start and end dates 1 day apart counts as 2 towards P:M ratio" do
    game = Game.new
    game.start_date = Date.yesterday
    game.end_date = Date.today

    assert_equal(2, game.pm_ratio_value)
  end

  test "game with start and end dates 2 days apart counts as 0 towards P:M ratio" do
    game = Game.new
    game.start_date = Date.today - 2
    game.end_date = Date.today
    
    assert_equal(0, game.pm_ratio_value)
  end
end
