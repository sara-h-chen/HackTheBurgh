{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-accessibility-package:SpeakSelection': => @SpeakSelection()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-accessibility-package:Magnify': => @Magnify()

  deactivate: ->
    @atomAccessibilityPackageView.destroy()

  serialize: ->
    atomAccessibilityPackageViewState: @atomAccessibilityPackageView.serialize()

  # Function to handle selected text and speak it aloud!
  SpeakSelection: ->
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

  Magnify: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()
      manager = new NotficationManager();
      atom.notifications.addInfo("selection");
