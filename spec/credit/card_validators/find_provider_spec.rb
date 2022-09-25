# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require_relative "../../spec_helper"

RSpec.describe Credit::CardValidators::FindProvider do
  describe "#call" do
    context "When calling for american express card number" do
      it "Returns 'AMEX'" do
        card_numbers = [378_282_246_310_005, "371449635398431"]
        card_numbers.each do |card_number|
          expect(described_class.new(card_number).call)
            .to eq(Credit::Card::AMERICAN_EXPRESS)
        end
      end
    end
    context "When calling for mastercard card number" do
      it "Returns 'MASTERCARD'" do
        card_numbers = [5_555_555_555_554_444, "5555555555554444",
                        5_105_105_105_105_100, "5105105105105100"]
        card_numbers.each do |card_number|
          expect(described_class.new(card_number).call)
            .to eq(Credit::Card::MASTERCARD)
        end
      end
    end
    context "When calling for visa card number" do
      it "Returns 'VISA'" do
        card_numbers = [4_111_111_111_111_111, "4111111111111111",
                        4_012_888_888_881_881, "4012888888881881"]
        card_numbers.each do |card_number|
          expect(described_class.new(card_number).call)
            .to eq(Credit::Card::VISA)
        end
      end
    end
    context "When calling for invalid card number" do
      it "Returns 'INVALID'" do
        card_numbers = [1_111_111_111_111_111, "211111111"]
        card_numbers.each do |card_number|
          expect(described_class.new(card_number).call)
            .to eq(Credit::Card::INVALID)
        end
      end
    end
    context "When calling for nonnumerical argument" do
      it "Raises ArgumentError for nonnumerical argument" do
        card_numbers = ["1_abc_567_890", "", "abc", nil, false, true]
        card_numbers.each do |_card_number|
          expect { described_class.new("123das") }
            .to raise_error(ArgumentError)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
