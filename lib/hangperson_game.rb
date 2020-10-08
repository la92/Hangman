class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  
  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def word
    @word = word
  end

  def guesses
    @guesses
  end

  def wrong_guesses
    @wrong_guesses
  end
  

  def guess(char)
    if char.nil? or /[^A-Za-z]/.match(char) !=nil or char ==''
      raise ArgumentError.new("Not a valid letter")
    end
    if @guesses.include? char or @wrong_guesses.include? char
      return false
    end

    if @word.include? char
      @guesses = @guesses+char
      return true
    end
  else
    @wrong_guesses = @wrong_guesses + char
    return true
  end

  def word_with_guesses
    @word.gsub(/[^ #{@guesses}]/,'-')
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      return :lose
    end
    if word_with_guesses == @word
      return :win
      end
    :play
  end



  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
