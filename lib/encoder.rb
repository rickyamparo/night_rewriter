require_relative 'alphabet'
require_relative 'lookup_module'

class Encoder

  include Lookup

  def initialize
    @alphabet = Alphabet.new
    @output =[]
    @offsets = [0,2,4]
  end

  def encode_to_braille(plain)
    offset_iterator(plain)
    @output.join
  end

  def letter_iterator(plain, offset)
    plain.chars.each do |letter|
      check_letter(letter, offset)
    end
  end

  def offset_iterator(plain)
    @offsets.each do |offset|
      letter_iterator(plain, offset)
      @output << "\n"
    end
  end

  def check_letter(letter, offset)
    if letter == letter.upcase
      @output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    @output << lookup(letter, offset) << lookup(letter, offset + 1)
  end

end
