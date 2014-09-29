_ = require "underscore"

class Navigation
  closeMenu: ->
    $('body').removeClass('open')

  toggleMenu: =>
    console.log 'toggleMenu'
    if $('body.open').length > 0
      @closeMenu()
    else
      $('body').addClass('open')

  handleScroll: (e) =>
    if $(e.target).scrollTop() <= 120
      $('body').removeClass('scrolled')
    else
      $('body').addClass('scrolled')

    demoTolerance = Math.max(0, Math.abs($('#demo').offset().top - $(document).scrollTop()))
    _.delay(@highlightNameField, 100) if demoTolerance < 100

  highlightNameField: ->
    $demo = $('#demo + section')
    $nameField = $demo.find('#name')
    $activeField = $demo.find('.input-container.active')

    unless $activeField.length
      $nameField.parent('.input-container').addClass('active')

    $demo
      .find('.input-container.active #name')
      .focus()
      .get(0).select()

  gotoAnchor: ($el) ->
    position = $($el.attr('href')).offset().top
    distance = position - $(document).scrollTop()
    speed = 10
    time = Math.abs(distance) / speed
    $('html, body').animate
      scrollTop: position
    , Math.floor time

  constructor: ->
    @_gotoAnchor   = _.throttle @gotoAnchor, 500, { trailing: false }
    @_handleScroll = _.throttle @handleScroll, 300, true
    @_toggleMenu   = _.throttle @toggleMenu, 300, true

    $('.menu').on 'click', @_toggleMenu

    $('.navigation [href]').on 'click', (e) =>
      e.preventDefault()
      @closeMenu()
      @_gotoAnchor($(e.currentTarget))

    $.each $('.title'), ->
      offset = $(this).find('a').outerWidth()
      $(this).find('.tooltip').css('left', offset)

    $(document).on 'scroll', @_handleScroll

module.exports = new Navigation()
