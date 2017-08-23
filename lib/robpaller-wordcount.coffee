RobpallerWordcountView = require './robpaller-wordcount-view'
{CompositeDisposable} = require 'atom'

module.exports = RobpallerWordcount =
  robpallerWordcountView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @robpallerWordcountView = new RobpallerWordcountView(state.robpallerWordcountViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @robpallerWordcountView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'robpaller-wordcount:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @robpallerWordcountView.destroy()

  serialize: ->
    robpallerWordcountViewState: @robpallerWordcountView.serialize()

  toggle: ->
    console.log 'RobpallerWordcount was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words  = editor.getText().split(/\s+/).length
      @robpallerWordcountView.setCount(words)
      @modalPanel.show()
