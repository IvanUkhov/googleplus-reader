class Photo
  constructor: (@attributes) ->

  load: (options, callback) ->
    options ||= {}

    width = options.width if options.width?

    if @attributes.width?
      if width?
        width = Math.min(width, @attributes.width)
      else
        width = @attributes.width

    if width?
      width = Math.round(width)
      url = @attributes.url.replace(/w\d+-h\d+(-p)?/, "w#{width}")
    else
      url = @attributes.url

    element = $('<img/>')

    if callback?
      element.on 'load', ->
        element.off('load')
        callback(element)

    element.attr(src: url)

    element

window.GooglePlus ||= {}
window.GooglePlus.Photo = Photo
