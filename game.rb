require './hangman'

include Hangman

def next_guess game
end

game = Game.new

loop do
    break if game.status != :continue

    Display.print(game)

    print "Guess a letter: "

    next_guess game
end
