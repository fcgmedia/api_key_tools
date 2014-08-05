require 'spec_helper'

describe ApiKeyTools::Encoder do
  describe "#encode" do
    let(:id){ 1 }
    let(:key){ "0a185854152be354388a105a727164d3" }
    let(:time){ Time.now.to_i }
    subject{ described_class.new(id, key, time) }
    it "should create a md5 hash" do
      expect(subject.to_s).to eq("51b61e2e0569a8f8929de0cbc25714f4abadcad2")
    end

    it "should create a valid as_json value" do
      expect(subject.as_json).to eq({ id: 1, key: "51b61e2e0569a8f8929de0cbc25714f4abadcad2", time: time })
    end
  end
end

describe ApiKeyTools::Validator do
  describe "#valid?" do
    let(:id){ 1 }
    let(:key){ "0a185854152be354388a105a727164d3" }
    let(:time){ Time.now.to_i }
    let(:encoder){ ApiKeyTools::Encoder.new(id, key, time) }
    subject{ ApiKeyTools::Validator.new(encoder, value) }
    context "valid value" do
      let(:value){ "51b61e2e0569a8f8929de0cbc25714f4abadcad2" }
      it "should be true" do
        subject
        Timecop.travel(Time.now + ApiKeyTools::Validator::TIME_THRESHOLD / 2)
        expect(subject.valid?).to eq(true)
      end
    end

    context "valid value but pass the time limit" do
      let(:value){ "51b61e2e0569a8f8929de0cbc25714f4abadcad2" }
      it "should be false" do
        subject
        Timecop.travel(Time.now + 10_000)
        expect(Time.at(time)).to_not eq(Time.now)
        expect(subject.valid?).to eq(false)
      end
    end

    context "invalid value" do
      let(:value){ "BAD_VALUE" }
      it "should be false" do
        expect(subject.valid?).to eq(false)
      end
    end
  end
end

