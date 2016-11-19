require 'spec_helper'
require 'pry'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    context '.new' do
      it 'generates secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end
      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]{4}/)
      end
      it 'should be different in each game' do
        outher_game = Game.new
        expect(game.instance_variable_get(:@secret_code)).not_to eq(outher_game.instance_variable_get(:@secret_code))
      end
    end
    context '#guess' do
      it 'chomp user guess'
      it 'check is digits'
      it 'check guess' do
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.guess('1234')).to eq([4, 0])
        expect(game.guess('1230')).to eq([3, 0])
        expect(game.guess('1200')).to eq([2, 0])
        expect(game.guess('1000')).to eq([1, 0])
        expect(game.guess('0000')).to eq([0, 0])
        expect(game.guess('0001')).to eq([0, 1])
        expect(game.guess('0103')).to eq([0, 2])
        expect(game.guess('2340')).to eq([0, 3])
        expect(game.guess('4321')).to eq([0, 4])
      end
      it 'check guess with duplicates' do
        game.instance_variable_set(:@secret_code, '1213')
        expect(game.guess('1000')).to eq([1, 0])
        expect(game.guess('0010')).to eq([1, 0])
        expect(game.guess('1100')).to eq([1, 1])
        expect(game.guess('0101')).to eq([0, 2])
        expect(game.guess('2131')).to eq([0, 4])
      end
      it 'makr guess'
    end

    context '#status' do
      it 'lose if not guess for number of attempts' do
        turns = game.instance_variable_get(:@number_of_turns)
        turns.times{game.guess('1000')}
        expect(game.status).to eq(:lose)
      end
      it 'win if code guessed' do
        code = game.instance_variable_get(:@secret_code)
        game.guess(code)
        expect(game.status).to eq(:win)
      end
      it 'offers to play again'
      it 'show history'
      it 'save progress'
    end

    context 'lose' do
      it 'offers to play again'
      it 'show history'
    end

    context 'hint' do
      it 'show hint' do
      hint = game.hint
      expect(game.instance_variable_get(:@secret_code)).to include(hint)
      end
    end
  end
end
