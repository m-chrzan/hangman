#!/bin/ruby

require './hangman'

include Hangman

def init
    Dir.mkdir('saves') unless Dir.exists?('saves')

    puts %Q{Select option:
  1) New game
  2) Load game }

    case get_new_or_load_choice
    when :new
        Game.new '5desk.txt'
    when :load
         begin
            Game.load("saves/#{get_filename}")
         rescue
             puts "Could not open file! Starting a new game."
             Game.new '5desk.txt'
         end
    end
end

def get_new_or_load_choice
    print '> '
    choice = gets.chomp
    case choice
    when '1'
        :new
    when '2'
        :load
    else
        puts "Invalid choice, try again."
        get_new_or_load_choice
    end
end

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
    when :good_guess, :bad_guess, :continue
        puts Display.print game
    when :invalid_guess
        puts "Already guessed that letter. Try again."
    end
end

game = init

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
