require 'spec_helper'

module Codebreaker
  RSpec.describe GameController do
    context '.validCode?' do
      it 'true with the correct code' do
        %w(1234 4321 1122 6543).each do |code|
          expect(GameController.validCode?(code)).to be true
        end
      end
      it 'false true with the incorrect code' do
        ['0000', '12345', 1234, 'MESSAGE', '7777'].each do |code|
          expect(GameController.validCode?(code)).to be false
        end
      end
    end
  end
end
