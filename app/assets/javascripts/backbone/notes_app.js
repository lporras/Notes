//= require_self
//= require_tree ./templates
//= require_tree ./models
//= require_tree ./views
//= require_tree ./routers

(function($) {

  window.NotesApp = {
    Models: {},
    Collections: {},
    Routers: {},
    Views: {},
    init: function(notes_json){
      window.notes = new NotesApp.Collections.Notes(notes_json);
      window.notesView = new NotesApp.Routers.Notes().notesView;
      if (!Backbone.history.started) {
        Backbone.history.start();
        Backbone.history.started = true;
      }
    }
  };

})(jQuery);