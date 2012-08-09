class NotesController < ApplicationController
  respond_to :html, :json

  def index
    @notes = Note.select("id, title, content, pos_x, pos_y, z_index")
    respond_with @notes
  end

  def create
    @note = Note.create(params[:note])
    respond_with @note
  end

  def update
    @note = Note.find(params[:id])
    @note.update_attributes(params[:note])
    respond_with @note
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_with @note
  end

end
