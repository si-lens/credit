# frozen_string_literal: true

module Credit
  module CardValidators
    class CalculateChecksum
      def initialize(card_number)
        @card_number = card_number
      end

      def call
        nums_array = Integer(@card_number).digits.reverse.reverse
        products = nums_array.each_with_index.map { |num, i| i.odd? ? num * 2 : num }
        (sum_products_digits(products) % 10).zero?
      rescue StandardError
        false
      end

      private

      def sum_products_digits(products)
        products.join.to_i.digits.sum
      end
    end
  end
end
