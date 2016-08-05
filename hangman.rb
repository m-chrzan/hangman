module Hangman
    class Game
        attr_reader :status, :guessed, :revealed

        def initialize(dictionary)
            raise DictionaryNotFound.new unless File.exists? dictionary
            @word = get_word dictionary
            @revealed = Array.new(@word.length)
            @letters_left = @word.length
            @tries_left = 6
            @guessed = {}

            puts @word

            @status = :continue
        end

        def make_guess letter
            if @guessed.include? letter
                @status = :invalid_guess
            elsif @word.include? letter
                @status = :good_guess
                @guessed[letter] = true
                update_revealed letter
            else
                @status = :bad_guess
                @guessed[letter] = false
                @tries_left -= 1
            end

            check_win_loss_conditions
        end

        def force_quit
            @status = :ended
        end

        private

        def get_word dictionary
            words = File.open(dictionary, 'r').readlines

            words.select! do |word| 
                word.chomp!
                word.length >= 5 && word.length <= 12
            end

            word = words.sample
            if word.nil?
                raise EmptyDictionary.new
            else
                word.downcase
            end
        end

        def update_revealed letter
            @word.each_char.with_index do |ch, i|
                if ch == letter
                    @revealed[i] = ch
                    @letters_left -= 1
                end
            end
        end

        def check_win_loss_conditions
            if @letters_left == 0
                @status = :won
            elsif @tries_left == 0
                @status = :lost
            end
        end
    end

    class Display
        def self.print game
        end
    end

    class DictionaryNotFound < IOError
    end

    class EmptyDictionary < StandardError
    end
end
