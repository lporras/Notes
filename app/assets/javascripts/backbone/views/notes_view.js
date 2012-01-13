(function($) {

  NotesApp.Views.NoteView = Backbone.View.extend({
    className: "postick",

    events: {
      "blur .title"       : "updateTitle",
      "blur .editable"    : "updateContent",
      "click span.delete" : "delete"
    },

    initialize: function(){
      _.bindAll(this, 'render', 'updateTitle', 'updateContent', 'update', 'leave', 'delete');
      this.model.bind('change', this.render);
      this.model.bind('destroy', this.leave);
      this.template = _.template($('#note-template').html());
      $(this.el).draggable({
        cancel: '.editable, .title, .delete',
        "zIndex": 3000,
        "stack" : '.postick'
      });
      $(this.el).bind("dragstop", this.update);
    },

    render: function(){
      var renderedContent = this.template(this.model.toJSON());
      var $el = $(this.el);
      $el.css({'top': this.model.get('top'), 'left': this.model.get('left')});
      $el.html(renderedContent);
      return this;
    },

    update: function(){
      var $el = $(this.el);
      var $title = this.$('.title');
      var $content = this.$('.editable');
      this.model.save({ title: $title.html(),
                        content: $content.html(),
                        left: $el.css('left'),
                        top: $el.css('top')
                      });
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
