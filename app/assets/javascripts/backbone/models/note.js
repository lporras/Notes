(function($) {

  NotesApp.Models.Note = Backbone.Model.extend({
    urlRoot: '/notes',
    defaults: {
      "title"   : "",
      "content" : "",
      "pos_x"    : "0px",
      "pos_y"     : "47px",
      "z_index" : 1
    }
  });

  NotesApp.Collections.Notes = Backbone.Collection.extend({
    model: NotesApp.Models.Note,
    url: '/notes'
  });

})(jQuery);