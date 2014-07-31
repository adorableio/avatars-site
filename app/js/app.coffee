_          = require('underscore')
characters = require('./characters')

class App
  BASEURL  : "http://api.adorable.io/avatar/"
  url      : ''
  size     : "180"
  radius   : "0"
  name     : "abott@adorable.png"
  maxsize  : 400
  tmpValue : ''

  constructor: ->
    @_handleInputEvent = _.throttle @handleInputEvent, 100
    @_setImageStyles =  _.debounce @setImageStyles, 100
    @_requestImage = _.debounce @requestImage, 400
    @setupEvents()

  setupEvents: ->
    $('input').on 'input', @handleInputEvent
    $('input[type=text]').on 'input', @_requestImage
    $('input').on 'change', @requestImage
    $('#png').on 'change', @handleInputEvent

  handleInputEvent: (e) =>
    $el = $(e.target)
    $for = $($el.data('for'))

    # If Checkbox
    return @setExtension(e, $for) if e.target.type == 'checkbox'

    # Otherwise
    value = $(e.target).val()
    @[e.target.id] = value
    $for.text(value)

    @url = "#{@BASEURL}#{@size}/#{@name}"
    @_setImageStyles()

  requestImage: (e) =>
    $el = $(e.target)
    $for = $($el.data('for'))
    @flash($for)
    @setImageURL()

  flash: ($for) ->
    $for.addClass('flash')
    setTimeout (-> $for.removeClass('flash')), 600

  processCharacter: (e) ->
    if $(e.target).hasClass('num')
      if not characters.isNumber(e.keyCode)
        e.preventDefault()

  setExtension: (e, $for) -> $for.toggle(e.target.checked)

  setImageURL: -> $('#demo-image').attr('src', @url)

  setImageStyles: ->
    $('#demo-image').css
      'width': @size
      'height': @size
      'border-radius': "#{@radius}%"

module.exports = new App()
