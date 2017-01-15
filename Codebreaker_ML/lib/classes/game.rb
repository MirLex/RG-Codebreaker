require 'yaml'
require 'pry'

module Codebreaker
  class Game
    attr_reader :code_size, :guess_history, :number_of_turns
    TEXT = YAML.load_file(File.expand_path('lib/data/text.yaml'))

    def initialize(code_size = 4, number_of_turns = 15)
      @code_size = code_size
      @secret_code = generate_code
      @number_of_turns = number_of_turns
      @guess_history = []
    end

    def guess(guess_code)
      @number_of_turns -= 1
      @guess_history << guess_code

      corr = @secret_code.chars.zip(guess_code.chars).select { |code, guess| code == guess }.count

      code = @secret_code.clone
      num_inc = guess_code.chars.map do |el|
        code[code.index(el)] = 'N' if code.include?(el)
      end.compact.size

      [corr, num_inc - corr]
    end

    def hint
      @secret_code.chars.sample
    end

    def status
      return :win if @guess_history.last == @secret_code
      :lose if @number_of_turns <= 0
    end

    def show_history
      lines = ["Secret code was: #{@secret_code}"]
      @guess_history.each_with_index do |guess, index|
        lines.push "attempt: #{index} guess: #{guess} "
      end
      lines
    end

    def save_history(user)
      user = Time.now.strftime('%d-%m-%Y-%H-%M') if user == ''
      file_path = 'game_history/' + user + '.yaml'
      File.open(file_path, 'w') { |f| f.write(YAML.dump(show_history)) }
      file_path
    end

    private

    def generate_code
      Array.new(code_size) { rand(1..6) }.join
    end
  end
end
