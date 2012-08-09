class NotesApp.Models.Note extends Backbone.Model
  urlRoot: '/notes'

  defaults:
    "title"     : ""
    "content"   : ""
    "pos_x"     : "0px"
    "pos_y"     : "47px"
    "z_index"   : 1

class NotesApp.Collections.Notes extends Backbone.Collection
  model: NotesApp.Models.Note

  url: '/notes'