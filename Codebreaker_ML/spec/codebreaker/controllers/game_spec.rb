require 'spec_helper'

module Codebreaker
  RSpec.describe GameController do
    context '.validCode?' do
      it 'validate code' do
        expect(GameController.validCode?('1234')).to be true
        expect(GameController.validCode?('1237')).to be false
        expect(GameController.validCode?('12345')).to be false
        expect(GameController.validCode?(1234)).to be false
        expect(GameController.validCode?('MESSAGE')).to be false
      end
    end
  end
end
