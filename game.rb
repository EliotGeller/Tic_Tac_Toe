require_relative 'board'

class Game

  attr_reader :winner

  def initialize(players)
    @players = players
    @board = Board.new
    start_game
  end

  def start_game
    puts "Starting a new game"
    puts "#{@players.first.name} goes first this game."
    play_loop
    puts @board.display
    puts announce_winner
  end

  def play_loop
    current_player, other_player = @players
    until @winner || !@board.spaces_left? do
      play_turn(current_player)
      current_player, other_player = other_player, current_player
    end
  end

  def play_turn(player)
    puts @board.display
    puts "It is #{player.name}'s turn."
    loop do
      target_cell = player.get_move
      break if @board.place_marker(target_cell, player.marker)
      puts "Invalid move."
    end
    @winner = player if @board.winner?(player)
  end

  def announce_winner
    @winner ? "#{@winner.name} won!" : "The game was a tie"
  end

end