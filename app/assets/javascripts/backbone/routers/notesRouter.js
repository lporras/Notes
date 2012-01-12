(function($) {

  NotesApp.Routers.Notes = Backbone.Router.extend({
    routes: {
      "": "index"
    },

    initialize: function(){
      this.notesView = new NotesApp.Views.NotesView({
        collection: window.notes
      });
    },

    index: function(){
      var $board = $("#board");
      $board.empty();
      this.notesView.render()
    }
  });

})(jQuery);
