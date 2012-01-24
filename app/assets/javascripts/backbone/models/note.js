(function($) {

  NotesApp.Models.Note = Backbone.Model.extend({
    defaults: {
      "title"   : "",
      "content" : "",
      "left"    : "0px",
      "top"     : "47px",
      "z_index" : 3000
    }
  });

  NotesApp.Collections.Notes = Backbone.Collection.extend({
    model: NotesApp.Models.Note,
    url: '/notes'
  });

})(jQuery);