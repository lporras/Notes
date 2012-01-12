(function($) {

  NotesApp.Views.NoteView = Backbone.View.extend({
    className: "postick",

    events: {
      "blur .title"  : "updateTitle",
      "blur .editable"   : "updateContent",
      "click span.delete" : "delete"
    },

    initialize: function(){
      _.bindAll(this, 'render', 'updateTitle', 'updateContent', 'leave', 'delete');
      this.model.bind('change', this.render);
      this.model.bind('destroy', this.leave);
      this.template = _.template($('#note-template').html());
    },

    render: function(){
      var renderedContent = this.template(this.model.toJSON());
      $(this.el).html(renderedContent);
      return this;
    },

    updateTitle: function(){
      var $title = this.$('.title');
      this.model.save({ title: $title.html() });
    },

    updateContent: function(){
      var $content = this.$('.editable');
      this.model.save({ content: $content.html() });
    },

    delete: function(){
      if (confirm('Are you sure you want to delete this Note?')) {
        this.model.destroy();
      }
    },

    leave: function(){
      this.unbind();
      var note_view = this;
      $(this.el).fadeOut('slow', function () {
        note_view.remove();
      });
    }


  });

  NotesApp.Views.NotesView = Backbone.View.extend({
    el: 'body',

    events: {
      "click #btn-addNote": "createNew"
    },

    initialize: function(){
      _.bindAll(this, 'render', 'createNew');
      this.collection.bind('reset', this.render);
    },

    render: function(){
      var $board = $("#board");
      $board.empty();
      this.collection.each(function(note){
        var noteView = new NotesApp.Views.NoteView({model: note});
        $board.append(noteView.render().el);
      });
      return this;
    },

    createNew: function(){
      var new_note = new NotesApp.Models.Note();
      var noteView = new NotesApp.Views.NoteView({model: new_note});
      this.collection.add(new_note);
      $("#board").append(noteView.render().el);
      new_note.save();
    }

  });

})(jQuery);
