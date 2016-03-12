module GamesHelper
    
    def applications_count(game)
        game.game_applications.to_a.reduce(0){|sum, game_application| sum += (game_application.is_pending? ? 1 : 0)}
    end
    
end
