# frozen_string_literal: true

require_relative "../../spec_helper"
RSpec.describe Credit::CardValidators::CalculateChecksum do
  describe "#call" do
    it "Returns true for valid card number" do
      card_numbers = [378_282_246_310_005, "371449635398431", 5_555_555_555_554_444,
                      "5555555555554444", 5_105_105_105_105_100, "5105105105105100",
                      4_111_111_111_111_111, "4111111111111111", 4_012_888_888_881_881,
                      "4012888888881881"]
      card_numbers.each do |card_number|
        expect(Credit::CardValidators::CalculateChecksum.new(card_number).call).to eq(true)
      end
    end

    it "Returns false for invalid card number" do
      card_numbers = [1_234_567_890, "1_234_567_890", 1, "1_abc_567_890",
                      "", 4_111_111_111_111_110, "4111111111111110", nil, false, true]
      card_numbers.each do |card_number|
        expect(Credit::CardValidators::CalculateChecksum.new(card_number).call).to eq(false)
      end
    end
  end
end
