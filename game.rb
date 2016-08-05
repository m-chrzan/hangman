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

def handle_status status
    case status
    when :ended
        throw :break, status
    when :good_guess, :bad_guess
        puts Game.board.to_s
    when :invalid_guess
        puts "Already guessed that letter. Try again."
    end
end

game = Game.new '5desk.txt'

result = catch(:break) do
    loop do
        handle_status game.status

        print "Guess a letter: "

        next_guess game
    end
end

puts "Game #{result}"
