module Decoder_Helpers

  def column_iterator(n)
    (0..(n-1)).each_slice(2) do |column_offset|
      braille_character = []
      row_iterator(braille_character, column_offset, n)
      decoded_braille = braille_decoder(braille_character.join)
      capital_check(decoded_braille)
    end
  end

  def row_iterator(braille_character, column_offset, n)
    (0..2).map {|row_offset|
      braille_character << braille_assembler(row_offset, column_offset[0], n)
      braille_character << braille_assembler(row_offset, column_offset[1], n)
    }
    braille_character
  end

  def braille_assembler(row, column, n)
    @lines.join[(row * n) + column]
  end

  def braille_decoder(braille_string)
    @alphabet.braille_letter_hash.key(braille_string)
  end

  def capital_check(decoded_braille)
    if decoded_braille == :capitalize
      @should_capitalize_next = true
    elsif @should_capitalize_next
      @output << decoded_braille.upcase
      @should_capitalize_next = false
    else
      @output << decoded_braille
      @should_capitalize_next = false
    end
  end

end
