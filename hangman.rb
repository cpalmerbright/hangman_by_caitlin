def hangman_main
  puts "Welcome to Hangman!"
  puts "Are you ready to begin? (y/n)"
  $prompt = "> "
  check_if_ready
end

def check_if_ready
  print $prompt
  while ready = gets.chomp
    case ready
    when "y"
      new_game
      break
    when "n"
      puts "OK, feel free to play another time! Bye!"
      exit
      break
    else
      puts "Please enter 'y' or 'n'"
      print $prompt
    end
  end
end

def new_game
  puts "Enter a word for another player to guess:"
  print $prompt
  while word_to_guess = gets.chomp.downcase
    if all_letters(word_to_guess) and word_to_guess.length >=3
      puts "Thanks - hiding word from player 2"
       50.times do
        puts "*"
        sleep(0.1)
      end
      break
    else
      puts "Must be a single word at least 3 characters long. Try again:"
      puts $prompt
    end
  end
  $hidden_word = []
  $correct_guesses = []
  $wrong_guesses = []
  win = false
  lose = false
  word_to_guess.length.times do
    $hidden_word.push('*')
  end
  show_guesses
  puts "Guess a letter: "
  print $prompt
  while guess = gets.chomp
    if all_letters(guess) && guess.length == 1
      check_letter(guess.downcase, word_to_guess.downcase)
    else
      puts "Please enter a single letter: "
      print $prompt
    end
  end
end

def check_letter(guess, word)
  if word[guess]
    if $correct_guesses.include? guess
      puts "That letter has already been selected."
    else
      puts "Good guess!\n\n"
      $correct_guesses.push(guess)
    end

    #replace asterisks with correct letters
    word_array = word.split('')
    word_array.each_with_index do |val, index|
      if word[index] == guess
        $hidden_word[index] = guess
      end
    end

    if $hidden_word.join().include? "*"
      show_guesses
      puts "Guess again: "
      print @prompt
    else
      success(word)
    end
  else
    puts "Sorry, there's no letter #{guess}.\n"
    if $wrong_guesses.include? guess
      puts "You already guessed that letter."
    else
      $wrong_guesses.push(guess)
    end
    show_guesses
    if $wrong_guesses.length >=7
      failure(word)
    else
      puts "Guess again: "
      print @prompt
    end
  end
end


def show_guesses
  puts "Word: " + $hidden_word.join()
  puts "Correct guesses: " + $correct_guesses.sort.join(', ')
  puts "Wrong guesses: " + $wrong_guesses.sort.join(', ') + "\n"
  puts $hangmen[$wrong_guesses.length]
  puts "\n"
end

def all_letters(str)
    str[/[a-zA-Z]+/]  == str
end

$hangmen = []
$hangmen[0] = "  +===+\n      |\n      |\n      |\n      |\n      |\n======="
$hangmen[1] = "  +===+\n  |   |\n      |\n      |\n      |\n      |\n======="
$hangmen[2] = "  +===+\n  |   |\n  0   |\n      |\n      |\n      |\n======="
$hangmen[3] = "  +===+\n  |   |\n  0   |\n  |   |\n      |\n      |\n======="
$hangmen[4] = "  +===+\n  |   |\n  0   |\n /|   |\n      |\n      |\n======="
$hangmen[5] = "  +===+\n  |   |\n  0   |\n /|\\  |\n      |\n      |\n======="
$hangmen[6] = "  +===+\n  |   |\n  0   |\n /|\\  |\n /    |\n      |\n======="
$hangmen[7] = "  +===+\n  |   |\n  0   |\n /|\\  |\n / \\  |\n      |\n======="

def success(word_to_guess)
  puts "Congratulations! You guessed it! The word was #{word_to_guess}"
  puts "Would you like to play again? "
  check_if_ready
end

def failure(word_to_guess)
    puts "Oh no! You ran out of lives!"
    puts "The word was '#{word_to_guess}'."
    puts "Would you like to play again? (y/n)"
    check_if_ready
end


hangman_main
