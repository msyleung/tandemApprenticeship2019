RSpec.describe ApplicationController, type: :controller do
  context "GET to /" do
    let(:response) { get "/" }
    it "returns status 200 OK" do
      expect(response.status).to eq 200
    end
  end
end
