require_relative 'game'
require_relative 'player'
require_relative 'input_helper'

class Session

  include InputHelper

  def initialize
    puts "Welcome to tic tac toe."
    @players = [
        create_player(:X),
        create_player(:O)
    ]
    @ties = 0
    play_loop
    puts "Goodbye."
  end

  private

  def create_player(marker)
    prompt "Who will play as #{marker}?"
    name = gets.chomp.strip
    Player.new(name, marker)
  end

  def play_loop
    loop do
      game = Game.new(games_played.even? ? @players : @players.reverse)
      @last_winner = game.winner
      update_scores
      puts scoreboard
      break unless play_again?

    end
  end

  def play_again?
    prompt "Play again? (y/n)"
    loop do
      answer = gets.strip[0].upcase
      case answer
      when "Y"
        return true
     when "N"
        return false
      else
        prompt "What was that? (type 'y' or 'n')"
      end
    end
  end

  def update_scores
    @last_winner ? @last_winner.increment_score : @ties += 1
  end



  def scoreboard
    scores_array = ["", "The score after #{games_played} game#{handle_plural(games_played)} :"]
    scores_array.concat(
      @players.map do |player|
        "#{player.name} has won #{player.score} time#{handle_plural(player.score)}"
      end
    )
    scores_array << "#{@players[0].name} and #{@players[1].name} have tied #{@ties} tie#{handle_plural(@ties)}"
    scores_array << ""
  end
  
  def games_played
    @ties + @players.reduce(0) {|a, e| a + e.score}
  end

  def handle_plural(value)
    's' unless value == 1
  end



end