require './lib/classes/game'
require './lib/controllers/gameController'

module Codebreaker
  class GameTerminal
    def initialize
      @game = Codebreaker::Game.new
    end

    def start
      text(:rules)

      loop do
        text(:make_guess)
        answer = gets.chomp
        action(answer)

        if Codebreaker::GameController.validCode?(answer)
          mark_guess(@game.guess(answer))
          game_over(@game.status) unless @game.status.nil?
        else
          text(:incorrect)
        end
      end
    end

    def text(message)
      puts Codebreaker::Game::TEXT[message]
    end

    def action(answer)
      quit if answer == 'quit'
      restart if answer == 'restart'
      puts @game.hint if answer == 'hint'
    end

    def restart
      text(:restart?)
      GameTerminal.new if gets.chomp == 'yes'
    end

    def quit
      text(:quit?)
      exec('exit') if gets.chomp == 'yes'
    end

    def save_history
      text(:save)
      if gets.chomp == 'yes'
        text(:initials)
        puts 'Game history save to: ' + @game.save_history(gets.chomp)
      end
    end

    def game_over(game_result)
      text(game_result)
      show_history
      save_history

      begin
        text(:restart)
        text(:quit)
        answer = gets.chomp
      end until action(answer)
    end

    def show_history
      @game.show_history.each { |line| puts line }
    end

    def mark_guess(guess)
      guess.first.times { print '+' }
      guess.last.times { print '-' }
      puts ''
    end
  end
end
