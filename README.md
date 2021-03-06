# Hangman

Hangman for the command-line interface.

Run `./game.rb` to start playing.

During gameplay you can save the current gamestate by entering "SAVE" instead of
a guess. You will be prompted for a file name, and the game will be saved in the
`saves/` directory. This will exit the game.

When starting the game again, you can load the file and pick up where you left 
off.

---

    $ ./game.rb 
    Select option:
      1) New game
      2) Load game 
    > 1
    Guesed letters:

          _______
         |/      |
         |     
         |     
         |     
         |     
         |
     jgs_|___
    _ _ _ _ _ _ _ _ _ _ 
    Guess a letter: _

    ...

    Guesed letters:
    E A R T L S F B C O N D 
          _______
         |/      |
         |      (_)
         |      \| 
         |       |
         |        
         |
     jgs_|___
    c a r b o n a t e d 
    You won the game!

---

Uses the *5desk* dictionary from [Scrapmaker](http://scrapmaker.com/view/twelve-dicts/5desk.txt).

ASCII gallows created by [Joan G. Stark](https://en.wikipedia.org/wiki/Joan_Stark)
(jgs), used non-commercially, as per her archived fair use [guidelines](http://web.archive.org/web/20091028023223/http://www.geocities.com/SoHo/7373/please.htm).
