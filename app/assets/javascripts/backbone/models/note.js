(function($) {

  NotesApp.Models.Note = Backbone.Model.extend({
    defaults: {
      "title"   : "",
      "content" : ""
    }
  });

  NotesApp.Collections.Notes = Backbone.Collection.extend({
    model: NotesApp.Models.Note,
    url: '/notes'
  });

})(jQuery);