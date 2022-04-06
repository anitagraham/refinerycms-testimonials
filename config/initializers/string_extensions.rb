module StringExtensions
  def bracket(open_bracket = '(', close_bracket = nil)

      close_bracket =  matching_bracket(open_bracket) if close_bracket.nil?
      open_bracket + self + close_bracket
  end

  private

    ASCII_BRACKETS = "()[]<>{}".freeze

    def matching_bracket(char)
      char.ascii_only? ? ascii_match_bracket(char) : unicode_match_bracket(char)
    end

    def ascii_match_bracket(char)
      ix = ASCII_BRACKETS.index(char)
      if ix.nil?
        char
      else
        ix.even? ? ASCII_BRACKETS[ix+1] : ASCII_BRACKETS[ix-1]
      end
    end

    # note 1: chr + 1 doesn't work for some of the ASCII brackets, which are separated by another character.
    # eg. "<=>, [\], {|}
    # note 2: This method only works if you send it the opening bracket
    def unicode_match_bracket(char)
      (char.ord + 1).chr(Encoding::UTF_8)
    end
end

class String
  include StringExtensions
end
