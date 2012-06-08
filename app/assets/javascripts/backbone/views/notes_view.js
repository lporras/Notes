(function($) {

  NotesApp.Views.NoteView = Backbone.View.extend({
    className: "postick",

    events: {
      "blur .title"       : "update",
      "blur .editable"    : "update",
      "click span.delete" : "delete"
    },

    initialize: function(){
      _.bindAll(this, 'render', 'update', 'leave', 'delete');
      this.model.bind('change', this.render);
      this.model.bind('destroy', this.leave);
      this.template = _.template($('#note-template').html());
      var $el = $(this.el);
      var this_view = this;
      $el.draggable({
        cancel: '.editable, .title, .delete',
        "zIndex": 3000,
        "stack" : '.postick',
        stop: this_view.update
      }).droppable({
        tolerance: 'touch',
        over: this_view.update,
        out: this_view.update
      });

    },

    render: function(){
      var renderedContent = this.template(this.model.toJSON());
      var $el = $(this.el);
      $el.css({'top': this.model.get('pos_y'), 'left': this.model.get('pos_x'), 'z-index': this.model.get('z_index')});
      $el.html(renderedContent);
      return this;
    },

    update: function(){
      var $el = $(this.el);
      var $title = this.$('.title');
      var $content = this.$('.editable');
      this.model.save({ title: $title.html(),
                        content: $content.html(),
                        pos_x: $el.css('left'),
                        pos_y: $el.css('top'),
                        z_index: $el.css('z-index')
                      });
    },

    delete: function(){
      if (confirm('Are you sure you want to delete this Note?')) {
        this.model.destroy();
      }
    },

    leave: function(){
      this.model.unbind('change', this.render);
      this.model.unbind('destroy', this.leave);
      var note_view = this;
      $(note_view.el).fadeOut('slow', function () {
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
