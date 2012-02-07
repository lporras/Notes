require 'spec_helper'

describe Note do
  before do
    WebMock.disable_net_connect!
    WebMock.reset!
    @pusher_url_regexp = %r{/apps/#{Pusher.app_id}/channels/notes/events}
    WebMock.stub_request(:post, @pusher_url_regexp).to_return(:status => 202)
  end

  describe "Mass Assignment" do
    it { should allow_mass_assignment_of(:title) }
    it { should allow_mass_assignment_of(:content) }
    it { should allow_mass_assignment_of(:pos_x) }
    it { should allow_mass_assignment_of(:pos_y) }
  end

  describe "Methods" do
    let(:note){ Factory(:note) }

    describe "#as_json" do
      context "when invoking with no params" do
        let(:json){ note.to_json }
        it "should return a json with just id, title and content" do
          json.should be_json_eql( note.to_json(:only => [:id, :content, :title, :pos_x, :pos_y, :z_index]) )
        end
      end
      context "when invoking with options" do
        let(:json){ note.to_json(:only => [:id, :content]) }
        it "should call to super with that options" do
          json.should be_json_eql( %({"id":"#{note.id}", "content":"#{note.content}" }) )
        end
      end
    end

    describe "#after_create" do
      it "sends a push notification to the pusher service" do
        note = Note.create(:title => "Test", :content => "Test")
        WebMock.should have_requested(:post, @pusher_url_regexp).with do |req|
                query_hash = req.uri.query_values
                query_hash["name"].should == 'created'
                query_hash["auth_key"].should == Pusher.key
                query_hash["auth_timestamp"].should_not be_nil

                parsed = MultiJson.decode(req.body)
                parsed.should == note.to_json
                req.headers['Content-Type'].should == 'application/json'
        end
      end
    end
  end


end