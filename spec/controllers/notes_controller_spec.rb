require 'spec_helper'

describe NotesController do
  describe "Routes" do
    it {{get: "/notes"}.should route_to(controller: "notes", action: "index")}
    it {{post: "/notes"}.should route_to(controller: "notes", action: "create")}
    it {{put: "/notes/1"}.should route_to(controller: "notes", action: "update", id: "1")}
    it {{delete: "/notes/1"}.should route_to(controller: "notes", action: "destroy", id: "1")}
  end

  describe "GET#index" do
    before do
      @notes = 3.times{|n| Factory(:note)}
    end

    it "should set the @notes instance variable" do
      get :index
      assigns(:notes).should_not be_nil
    end

    it "should assign to @notes all notes" do
      get :index
      assigns(:notes).should == Note.select("id, title, content")
    end

    it "should render index template" do
      get :index
      response.should render_template :index
    end

    context "get with json format" do
      it "should assign to @notes all notes as json" do
        get :index, format: :json
        assigns(:notes).should_not be_nil
        response.body.should be_json_eql( Note.select("id, title, content").to_json )
      end
    end
  end

  describe "POST#create" do
    before do
      @note_attributes = Factory.attributes_for(:note)
    end

    it "should set the @note instance variable" do
      post :create, note: @note_attributes, format: :json
      assigns(:note).should_not be_nil
    end

    it "should create a new note" do
      expect{
        post :create, note: @note_attributes, format: :json
      }.to change(Note, :count).by(1)
    end

    context "with format json" do
      it "should create a new note" do
        expect{
          post :create, note: @note_attributes, format: :json
        }.to change(Note, :count).by(1)
      end

      it "should response with json of note" do
        post :create, note: @note_attributes, format: :json
        response.body.should be_json_eql( assigns(:note).to_json )
      end
    end
  end

  describe "POST#update" do
    before do
      @note = Factory(:note)
      @params = {title: "titulo", content: "contenido"}
    end

    it "should set the @note instance variable" do
      put :update, note: @params, id: @note.id
      assigns(:note).should_not be_nil
    end

    context "with format json" do
      it "should response with json of note" do
        put :update, note: @params, id: @note.id, format: :json
        response.body.should be_json_eql( assigns(:note).to_json )
      end

      it "should update the note" do
        put :update, note: @params, id: @note.id, format: :json
        assigns(:note).title.should == "titulo"
        assigns(:note).content.should == "contenido"
      end
    end
  end

  describe "DELETE#destroy" do
    before do
      @note = Factory(:note)
    end

    it "should set the @note instance variable" do
      delete :destroy, id: @note.id, format: :json
      assigns(:note).should_not be_nil
    end

    it "should decrease count of Note by 1" do
      expect{
        delete :destroy, id: @note.id, format: :json
      }.to change(Note, :count).by(-1)
    end

    it "should response with json of note" do
      delete :destroy, id: @note.id, format: :json
      response.body.should be_json_eql( assigns(:note).to_json )
    end
  end

end
