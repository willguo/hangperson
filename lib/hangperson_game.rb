class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
#
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)

    #letter.downcase!
    
    if (letter.nil?)
      raise ArgumentError
    end

    if (letter.length <= 0 or !(letter =~ /[[:alpha:]]/))
      raise ArgumentError
    end

    letter.downcase!

    if @word.include? letter
      if !@guesses.include? letter
        @guesses=(@guesses << letter)
      else
        return false
      end
    elsif !@word.include? letter
      if !@wrong_guesses.include? letter
        @wrong_guesses=(@wrong_guesses << letter)
      else
        return false
      end
    end
  end

  def word_with_guesses
    temp = ''
    word.split("").each do |i|
      if @guesses.include? i
        temp << i
      else
        temp << '-'
      end
    end
    
    return temp
  end

  def check_win_or_lose
    if wrong_guesses.length >= 7
      return :lose
    end
    
    word.split("").each do |i|
      if !@guesses.include? i
        return :play
      end
    end

    return :win
  end

end
