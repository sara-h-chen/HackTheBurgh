AtomAccessibilityView = require './atom-accessibility-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomAccessibility =
  atomAccessibilityView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomAccessibilityView = new AtomAccessibilityView(state.atomAccessibilityViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomAccessibilityView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-accessibility:SpeakSelection': => @SpeakSelection()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-accessibility:Magnify': => @Magnify()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-accessibility:ShutUp': => @ShutUp()


  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomAccessibilityView.destroy()

  serialize: ->
    atomAccessibilityViewState: @atomAccessibilityView.serialize()

  # Function to handle selected text and speak it aloud!
  SpeakSelection: ->
    console.log("Speak Selection Activated!")
    if editor = atom.workspace.getActiveTextEditor()
      # Get selected text
      selection = editor.getSelectedText()
      speechSynthesiser = window.speechSynthesis
      voices = speechSynthesiser.getVoices()
      # Transform selected text into an object the synthesiser can use.
      utterance = new SpeechSynthesisUtterance(selection)
      utterance.pitch = 1
      utterance.rate = 1
      utterance.voice = voices[0]
      speechSynthesiser.speak(utterance)

  # Function to stop speaking
  ShutUp: ->
    speechSynthesiser = window.speechSynthesis
    speechSynthesiser.cancel()

  Magnify: ->
    console.log(selection)
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      @atomAccessibilityView.setText(selection)
      @modalPanel.show()
