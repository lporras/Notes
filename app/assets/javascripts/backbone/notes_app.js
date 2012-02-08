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

  var pusher = new Pusher('4e629923ec75d019fc38');
  var channel = pusher.subscribe('notes');

  channel.bind('created', function(data){
    if(!notes.get(data)){
      var note = new notes.model(data);
      notes.add(note);
      notesView.render();
    }
  });

  channel.bind('updated', function(data){
    var note = notes.get(data)
    if(note){
      note.set(data);
    }else{
      notes.add(data);
    }
    notesView.render();
  });

  channel.bind('destroyed', function(data){
    var note = notes.get(data);
    if(note){
      notes.remove(note);
    }
    notesView.render();
  });
})(jQuery);