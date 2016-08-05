#!/bin/ruby

require './hangman'

include Hangman

def next_guess game
    guess = gets
    if guess.nil?
        game.force_quit
    else
        guess.chomp!
        case guess
        when /^[a-zA-Z]$/
            game.make_guess guess
        when "SAVE"
            game.save("saves/#{get_filename}")
            game.force_quit
        else
            puts "Invalid guess. Try again."
        end
    end
end

def get_filename
    print "Enter file name: "
    gets.chomp
end

def handle_status game
    case game.status
    when :ended, :won, :lost
        throw :break, game.status
    when :good_guess, :bad_guess
        puts Display.print game
    when :invalid_guess
        puts "Already guessed that letter. Try again."
    end
end

game = Game.new '5desk.txt'

result = catch(:break) do
    loop do
        handle_status game

        print "Guess a letter: "

        next_guess game
    end
end

case result
when :won, :lost
    game.reveal
    puts Display.print game
    puts "You #{result} the game!"
else
    puts
end
