describe Vidyo::Token do
  subject { described_class.new(params) }
  let(:params) do
    {
      key: "vidyo_key",
      application_id: "application_id",
      user_name: "john.smith",
      expires_in: 3600
    }
  end

  context "pinning all tests to a fixed time" do
    let(:timestamp) do
      DateTime.parse("2017-11-21 11:38:07 +0000")
    end

    before do
      Timecop.freeze(timestamp)
      allow(subject).to \
        receive(:expires_at).\
        and_return(63678505087)
    end

    describe "body" do
      let(:body) { 
        [112, 114, 111, 118, 105, 115, 105, 111, 110, 0, 106, 111, 104, 110, 46, 115, 109, 105, 116, 104, 64, 97, 112, 112, 108, 105, 99, 97, 116, 105, 111, 110, 95, 105, 100, 0, 54, 51, 54, 55, 56, 53, 48, 53, 48, 56, 55, 0]
      }
      it "matches" do
        expect(subject.body).to eq(body)
      end
    end

    describe "mac" do
      let(:hexdigest) {
        "cf0a7039456dcf1089c36198969d39e267fcd25cd8f06322da1e86b656217a70518046b5b06cb1b2d9815bc515a8d165"
      }

      it "matches" do
        expect(subject.mac.hexdigest).to eq(hexdigest)
      end
    end

    describe "unserialized" do
      let(:unserialized) {
        [112, 114, 111, 118, 105, 115, 105, 111, 110, 0, 106, 111, 104, 110, 46, 115, 109, 105, 116, 104, 64, 97, 112, 112, 108, 105, 99, 97, 116, 105, 111, 110, 95, 105, 100, 0, 54, 51, 54, 55, 56, 53, 48, 53, 48, 56, 55, 0, 0, 99, 102, 48, 97, 55, 48, 51, 57, 52, 53, 54, 100, 99, 102, 49, 48, 56, 57, 99, 51, 54, 49, 57, 56, 57, 54, 57, 100, 51, 57, 101, 50, 54, 55, 102, 99, 100, 50, 53, 99, 100, 56, 102, 48, 54, 51, 50, 50, 100, 97, 49, 101, 56, 54, 98, 54, 53, 54, 50, 49, 55, 97, 55, 48, 53, 49, 56, 48, 52, 54, 98, 53, 98, 48, 54, 99, 98, 49, 98, 50, 100, 57, 56, 49, 53, 98, 99, 53, 49, 53, 97, 56, 100, 49, 54, 53]
      }
      it "matches" do
        expect(subject.unserialized.unpack('C*')).to eq(unserialized)
      end
    end

    describe "serialize" do
      let(:serialized) {
        "cHJvdmlzaW9uAGpvaG4uc21pdGhAYXBwbGljYXRpb25faWQANjM2Nzg1MDUwODcAAGNmMGE3MDM5NDU2ZGNmMTA4OWMzNjE5ODk2OWQzOWUyNjdmY2QyNWNkOGYwNjMyMmRhMWU4NmI2NTYyMTdhNzA1MTgwNDZiNWIwNmNiMWIyZDk4MTViYzUxNWE4ZDE2NQ=="
      }

      it "matches" do
        expect(subject.serialize).to eq(serialized)
      end
    end
  end

  context "with the current time" do
    it "returns a key" do
      expect { subject.serialize }.not_to raise_exception
    end
  end
end
