require 'spec_helper'
require 'pry'

module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    context '.new' do
      it 'generates secret code'
    end
    context '#guess' do
      it 'chomp user guess'
      it 'check guess' 
      it 'makr guess'
    end

    context '#win' do
      it 'congratulate user'
      it 'offers to play again'
      it 'show history'
      it 'save progress'
    end

    context 'lose' do
      it 'offers to play again'
      it 'show history'
    end

    context 'hint' do
      it 'show hint' 
    end
  end
end
