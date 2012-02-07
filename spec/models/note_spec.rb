require 'spec_helper'

describe Note do
  before do
    stub_or_flush_pusher_requests
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
  end

  describe "Callbacks" do
    describe "#after_save" do
      it "sends appropiate push notifications to the pusher service" do
        note = Factory(:note)
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

    describe "#after_update" do
      it "sends appropiate push notifications to the pusher service" do
        note = Factory(:note)
        stub_or_flush_pusher_requests
        note.update_attribute(:title, "new title")
        WebMock.should have_requested(:post, @pusher_url_regexp).with do |req|
                query_hash = req.uri.query_values
                query_hash["name"].should == 'updated'
                query_hash["auth_key"].should == Pusher.key
                query_hash["auth_timestamp"].should_not be_nil
                p query_hash
                parsed = MultiJson.decode(req.body)
                parsed.should == note.to_json
                req.headers['Content-Type'].should == 'application/json'
        end
      end
    end
  end
end