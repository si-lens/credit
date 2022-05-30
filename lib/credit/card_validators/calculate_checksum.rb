# frozen_string_literal: true

module Credit
  module CardValidators
    class CalculateChecksum
      def initialize(card_number)
        @card_number = card_number
      end

      def call
        nums_array = @card_number.to_i.digits.reverse.reverse
        products = nums_array.each_with_index.map { |num, i| i.odd? ? num * 2 : num }
        (sum_products_digits(products) % 10).zero?
      end

      private

      def sum_products_digits(products)
        products.join.to_i.digits.sum
      end
    end
  end
end
