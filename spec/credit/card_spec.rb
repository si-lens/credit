# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require_relative "../spec_helper"

RSpec.describe Credit::Card do
  it "Returns AMEX for visa card number" do
    card_numbers = [378_282_246_310_005, "371449635398431", "3714-4963-5398-431"]
    card_numbers.each do |card_number|
      expect(Credit::Card.new.validate(card_number)).to eq("AMEX")
    end
  end

  it "Returns MASTERCARD for visa card number" do
    card_numbers = [5_555_555_555_554_444, "5555555555554444", "5555-5555-5555-4444",
                    5_105_105_105_105_100, "5105105105105100", "5105-1051-0510-5100"]
    card_numbers.each do |card_number|
      expect(Credit::Card.new.validate(card_number)).to eq("MASTERCARD")
    end
  end

  it "Returns VISA for visa card number" do
    card_numbers = [4_111_111_111_111_111, "4111111111111111", "41-111-111-1111-11-11",
                    4_012_888_888_881_881, "4012888888881881", "40-12888-88888-1881"]
    card_numbers.each do |card_number|
      expect(Credit::Card.new.validate(card_number)).to eq("VISA")
    end
  end

  it "Returns INVALID for invalid card number" do
    card_numbers = [1_234_567_890, "1_234_567_890", "1_abc_567_890", "", 1, "abc", nil,
                    "4111111111111110"]
    card_numbers.each do |card_number|
      expect(Credit::Card.new.validate(card_number)).to eq("INVALID")
    end
  end

  it "Returns INVALID for invalid card number and does not call checksum calculation" do
    card_number = "1_abc_567_890"
    mock = double("calculate_checksum")
    expect(mock).not_to receive(:call).with(card_number)
    Credit::CardValidators::CalculateChecksum.new(mock)
    expect(Credit::Card.new.validate(card_number)).to eq("INVALID")
  end
end
# rubocop:enable Metrics/BlockLength
