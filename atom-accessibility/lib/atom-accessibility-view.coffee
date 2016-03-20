module.exports =
class AtomAccessibilityView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('atom-accessibility')

    # Create message element
    message = document.createElement('div')
    message.textContent = ""
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  setText: (text) ->
    displayText = "#{text}"
    @element.children[0].textContent = displayText
