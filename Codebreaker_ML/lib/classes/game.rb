module Codebreaker
  class Game
    attr_reader :code_size

    def initialize(code_size = 4)
      @code_size = code_size
      @secret_code = generate_code
    end

    def guess(guess_code)
      corr = (0...code_size).map { |i| @secret_code[i] == guess_code[i] ? 1 : 0 }.reduce(:+)

      code = @secret_code.clone
      num_inc = (0...code_size).map do |i|
        if code.include?(guess_code[i])
          code[code.index(guess_code[i])] = 'N'
          1
        else
          0
        end
      end.reduce(:+)

      [corr, num_inc - corr]
    end

    def hint
      @secret_code[rand(0...code_size)]
    end

    private

    def generate_code
      (0...code_size).map { rand(1..6) }.join
    end
  end
end
