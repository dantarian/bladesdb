class ChangeRankBracketOnGamesToPointsBrackets < ActiveRecord::Migration
  def self.up
    Game.update_all ["lower_rank = lower_rank * 10"]
    Game.update_all ["upper_rank = upper_rank * 10"]
  end

  def self.down
    Game.update_all ["lower_rank = lower_rank / 10"]
    Game.update_all ["upper_rank = upper_rank / 10"]
  end
end
