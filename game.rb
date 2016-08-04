require './hangman'

include Hangman

def next_guess game
    guess = gets
    if guess.nil?
        game.force_quit
    else
        guess.chomp!
    end

    puts guess
end

game = Game.new '5desk.txt'

loop do
    break if game.status != :continue

    Display.print(game)

    print "Guess a letter: "

    next_guess game
end
