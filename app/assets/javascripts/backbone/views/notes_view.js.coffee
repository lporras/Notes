class NotesApp.Views.NoteView extends Backbone.View
  className: "postick"

  events:
    "blur .title"       : "update"
    "blur .editable"    : "update"
    "click span.delete" : "delete"

  initialize: ->
    @model.bind 'change', @render
    @model.bind 'destroy', @leave
    @template = _.template $('#note-template').html()
    this_view = this
    @$el.draggable
      cancel: '.editable, .title, .delete'
      "zIndex": 3000
      "stack" : '.postick'
      stop: this_view.update
    .droppable
      tolerance: 'touch'
      over: this_view.set
      out: this_view.update

  render: =>
    renderedContent = @template(@model.toJSON())
    @$el.css
      'top'     : @model.get('pos_y')
      'left'    : @model.get('pos_x')
      'z-index' : @model.get('z_index')
    @$el.html(renderedContent)
    return this

  update: =>
    attributes = @getPossibleAttributes()
    if @model.anyChange(attributes)
      @model.save(attributes)

  getPossibleAttributes: ->
    $title = @$('.title')
    $content = @$('.editable')
    return {title: $title.html(), content: $content.html(), pos_x: @$el.css('left'), pos_y: @$el.css('top'), z_index : parseInt(@$el.css('z-index'))}

  set: =>
    @model.set @getPossibleAttributes()

  delete: =>
    unless @model.isNew()
     @model.destroy() if confirm "Are you sure you want to delete this Note?"
    else
      @model.destroy()

  leave: =>
    @model.unbind 'change', @render
    @model.unbind 'destroy', @leave
    note_view = this
    @$el.fadeOut 'slow', ->
      note_view.remove()

class NotesApp.Views.NotesView extends Backbone.View
  el: 'body'

  events:
    "click #btn-addNote": "createNew"

  render: =>
    $board = @$("#board")
    $board.empty()
    @collection.each (note) ->
      noteView = new NotesApp.Views.NoteView(model: note)
      $board.append noteView.render().el
    return this

  createNew: =>
    new_note = new NotesApp.Models.Note()
    noteView = new NotesApp.Views.NoteView(model: new_note)
    @collection.add(new_note)
    @$("#board").append noteView.render().el
