class NotesController < ApplicationController
  respond_to :html, :json

  def index
    @notes = Note.select("id, title, content")
    respond_with(@notes) do |format|
      format.json { render json: @notes }
    end
  end

  def create
    @note = Note.create(params[:note])
    respond_with(@note) do |format|
      format.json { render json: @note }
    end
  end

  def update
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note])
    respond_with(@note) do |format|
      format.json { render json: @note }
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_with(@note) do |format|
      format.json { render json: @note }
    end
  end

end
