_          = require('underscore')
characters = require('./characters')
navigation = require('./navigation')

class App
  BASEURL  : "http://api.adorable.io/avatars/"
  url      : ''
  size     : "285"
  radius   : "0"
  name     : "abott@adorable.io.png"
  maxsize  : 400
  tmpValue : ''

  constructor: ->
    @_handleInputEvent = _.throttle @handleInputEvent, 100
    @_setImageStyles =  _.debounce @setImageStyles, 100
    @_requestImage = _.debounce @requestImage, 400
    @url = "#{@BASEURL}#{@size}/#{@name}"
    @setupEvents()

  setupEvents: ->
    $('input').on 'input', @handleInputEvent
    $('input[type=text]').on 'input', @_requestImage
    $('input').on 'change', @requestImage
    $('#png').on 'change', @handleInputEvent
    $('.input-container').on 'click', @setActive

  handleInputEvent: (e) =>
    $el = $(e.target)
    $for = $($el.data('for'))

    # If Checkbox
    return @setExtension(e, $for) if e.target.type == 'checkbox'

    # Otherwise
    @setActive($el)

    value = $el.val()
    @[e.target.id] = encodeURIComponent(value)
    $for.text(value)

    @url = "#{@BASEURL}#{@size}/#{@name}"
    @_setImageStyles()

  setActive: (el) ->
    el = el.target if el.type
    $el = $(el)
    $('.input-container').removeClass('active')
    $el.closest('.input-container').addClass('active')

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

client = new ZeroClipboard($("#copy-button"))

client.on "ready", (readyEvent) ->
  client.on "copy", (e) ->
    clipboard = e.clipboardData
    clipboard.setData('text/plain', app.url)

  client.on "aftercopy", (e) ->
    $el   = $(e.target)
    $prev = $el.prev()
    app.flash($prev)

module.exports = app = new App()
