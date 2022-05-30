# frozen_string_literal: true

module Credit
  class Card
    VISA = "VISA"
    MASTERCARD = "MASTERCARD"
    AMERICAN_EXPRESS = "AMEX"
    INVALID = "INVALID"

    def validate(card_number)
      card_number = format_card_number(card_number)
      return INVALID unless valid_length?(card_number)
      return INVALID unless CardValidators::CalculateChecksum.new(card_number).call

      CardValidators::FindProvider.new(card_number).call
    end

    private

    def format_card_number(card_number)
      if card_number.is_a?(String)
        card_number = card_number.gsub("-", "")
        Integer(card_number)
        card_number
      else
        card_number.to_s
      end
    rescue StandardError
      INVALID
    end

    def valid_length?(card_number)
      CardValidators::VALID_LENGTHS.include?(card_number.length)
    end
  end
end
