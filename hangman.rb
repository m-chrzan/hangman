module Hangman
    class Game
        attr_reader :status, :guessed, :revealed

        def initialize(dictionary)
            raise DictionaryNotFound.new unless File.exists? dictionary
            @word = get_word dictionary
            @revealed = Array.new(@word.length)
            @letters_left = @word.length
            @guessed = {}

            puts @word

            @status = :continue
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
                word
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
