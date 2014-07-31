_          = require('underscore')
characters = require('./characters')

class App
  baseurl  : "http://api.adorable.io/avatar/"
  sizexurl : "300"
  sizeyurl : "300"
  nameurl  : "bloop.png"
  maxsize  : 400
  tmpValue : ''

  constructor: ->
    @_handleInputEvent = _.throttle @handleInputEvent, 300
    @setupEvents()

  setupEvents: ->
    $('input').on 'input', @_handleInputEvent
    $('#png').on 'change', @handleInputEvent

  handleInputEvent: (e) =>
    $el = $(e.target)
    $for = $($el.data('for'))

    # If Checkbox
    return @setExtension(e, $for) if e.target.type == 'checkbox'

    # Otherwise
    value = $(e.target).val()
    @[e.target.id + 'url'] = value
    $for.text(value)
    @setURL()


  processCharacter: (e) ->
    if $(e.target).hasClass('num')
      if not characters.isNumber(e.keyCode)
        e.preventDefault()

  setExtension: (e, $for) -> $for.toggle(e.target.checked)

  setURL: ->
    url = "#{@baseurl}#{@sizexurl}x#{@sizexurl}/#{@nameurl}"
    $('#demo-image').attr('src', url)

module.exports = new App()
