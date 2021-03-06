module Codebreaker
  class GameController
    def self.valid_code?(code)
      return false unless code.size == 4
      code.match(/[1-6]{4}/) ? true : false
    end
  end
end
