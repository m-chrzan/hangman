module Hangman
    class Game
        attr_reader :status, :guessed, :revealed, :tries_left

        def initialize(dictionary)
            raise DictionaryNotFound.new unless File.exists? dictionary
            @word = get_word dictionary
            @revealed = Array.new(@word.length)
            @letters_left = @word.length
            @tries_left = 6
            @guessed = {}

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

        def reveal
            @word.each_char.with_index do |ch, i|
                @revealed[i] = ch
            end
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
            display = ""
            display << (guessed_letters game)
            display << "\n"
            display << (gallows game)
            display << "\n"
            display << (form_word game)
            display << "\n"

            display
        end

        private
        def self.guessed_letters game
            guessed = ""
            game.guessed.each do |ch, _|
                guessed << ch
            end

            guessed
        end

        def self.gallows game
            "#{game.tries_left} wrong guesses left."
        end

        def self.form_word game
            word = ""
            game.revealed.each do |ch|
                if ch.nil?
                    word << '_'
                else
                    word << ch
                end

                word << ' '
            end

            word
        end
    end

    class DictionaryNotFound < IOError
    end

    class EmptyDictionary < StandardError
    end
end
