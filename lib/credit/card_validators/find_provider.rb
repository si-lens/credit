# frozen_string_literal: true

module Credit
  module CardValidators
    VISA_VALID_PREFIX = 4
    VISA_VALID_LENGTH = [13, 16].freeze

    MASTERCARD_VALID_PREFIX = [51, 52, 53, 54, 55].freeze
    MASTERCARD_VALID_LENGTH = 16

    AMERICAN_EXPRESS_VALID_PREFIX = [34, 37].freeze
    AMERICAN_EXPRESS_VALID_LENGTH = 15

    VALID_LENGTHS = [VISA_VALID_LENGTH, MASTERCARD_VALID_LENGTH,
                     AMERICAN_EXPRESS_VALID_LENGTH].flatten.freeze

    class FindProvider
      def initialize(card_number)
        @card_number = Integer(card_number).to_s
        @card_number_length = card_number.to_s.length
      end

      def call
        return Card::VISA if visa?
        return Card::MASTERCARD if mastercard?
        return Card::AMERICAN_EXPRESS if american_express?

        Card::INVALID
      end

      private

      def visa?
        VISA_VALID_LENGTH.include?(@card_number_length) && VISA_VALID_PREFIX == @card_number[0].to_i
      end

      def mastercard?
        MASTERCARD_VALID_LENGTH == @card_number_length &&
          MASTERCARD_VALID_PREFIX.include?(@card_number[0..1].to_i)
      end

      def american_express?
        AMERICAN_EXPRESS_VALID_LENGTH == @card_number_length &&
          AMERICAN_EXPRESS_VALID_PREFIX.include?(@card_number[0..1].to_i)
      end
    end
  end
end
