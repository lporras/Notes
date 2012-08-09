class NotesApp.Routers.Notes extends Backbone.Router
  routes:
    "": "index"

  initialize: ->
    @notesView = new NotesApp.Views.NotesView(collection: window.notes)

  index: =>
    @notesView.render()