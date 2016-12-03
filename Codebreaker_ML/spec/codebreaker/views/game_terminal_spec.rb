require 'spec_helper'
require 'pry'

module Codebreaker
  RSpec.describe GameTerminal do
    let(:game) { GameTerminal.new }

    context '#text' do
      it 'puts game messages' do
        expect { game.text(:rules) }.to output(/RULES/).to_stdout
        expect { game.text(:make_guess) }.to output(/Make guess/).to_stdout
        expect { game.text(:incorrect) }.to output(/Input Error/).to_stdout
        expect { game.text(:hint) }.to output(/hint/).to_stdout
        expect { game.text(:quit) }.to output(/quit/).to_stdout
        expect { game.text(:restart) }.to output(/restart/).to_stdout
        expect { game.text(:win) }.to output(/win/).to_stdout
        expect { game.text(:lose) }.to output(/lose/).to_stdout
        expect { game.text(:save) }.to output(/save/).to_stdout
      end
    end

    context '#action' do
      it 'check if user input if a system command [quit]' do
        expect(game).to receive(:puts).with('Enter "yes" to exit the game')
        game.stub(:gets).and_return('no')
        game.action('quit')
      end

      it 'check if user input if a system command [restart]' do
        expect(game).to receive(:puts).with('Enter "yes" to play again')
        game.stub(:gets).and_return('no')
        game.action('restart')
      end

      it 'check if user input if a system command [hint] and get it ' do
        expect(game).to receive(:puts).with(/[1-6]/)
        game.stub(:gets).and_return('no')
        game.action('hint')
      end
    end

    context '#restart' do
      it 'porpose to play again' do
        expect(game).to receive(:puts).with('Enter "yes" to play again')
        game.stub(:gets).and_return('no')
        game.restart
      end
    end

    context '#quit' do
      it 'porpose to exit from the game' do
        expect(game).to receive(:puts).with('Enter "yes" to exit the game')
        game.stub(:gets).and_return('no')
        game.quit
      end
    end

    context '#save_history' do
      it 'ask user to save game history' do
        expect(game).to receive(:puts).with('Enter "yes" to save game history')
        game.stub(:gets).and_return('no')
        game.save_history
      end
    end

    context '#show_history' do
      it 'show game process history' do
        expect { game.show_history }.to output(/Secret code was:/).to_stdout
      end
    end

    context '#mark_guess' do
      it 'makr guess' do
        expect { game.mark_guess([0, 0]) }.to output("\n").to_stdout
        expect { game.mark_guess([1, 0]) }.to output("+\n").to_stdout
        expect { game.mark_guess([2, 0]) }.to output("++\n").to_stdout
        expect { game.mark_guess([3, 0]) }.to output("+++\n").to_stdout
        expect { game.mark_guess([4, 0]) }.to output("++++\n").to_stdout
        expect { game.mark_guess([3, 1]) }.to output("+++-\n").to_stdout
        expect { game.mark_guess([2, 2]) }.to output("++--\n").to_stdout
        expect { game.mark_guess([1, 3]) }.to output("+---\n").to_stdout
        expect { game.mark_guess([0, 4]) }.to output("----\n").to_stdout
        expect { game.mark_guess([0, 3]) }.to output("---\n").to_stdout
        expect { game.mark_guess([0, 2]) }.to output("--\n").to_stdout
        expect { game.mark_guess([0, 1]) }.to output("-\n").to_stdout
      end
    end
  end
end
