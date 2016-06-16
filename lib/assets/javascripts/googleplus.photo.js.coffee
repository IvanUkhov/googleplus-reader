unless typeof define is 'function' and define.amd
  module = @GooglePlus ||= {}
  @define = (name, deps, callback) ->
    module.Photo = callback(jQuery)

define 'googleplus.photo', ['jquery'], ($) ->
  class
    constructor: (@attributes) ->

    load: (options = {}) ->
      deferred = $.Deferred()

      element = $('<img/>')
      element
        .on 'load', ->
          element.off('load error')
          deferred.resolve(element)
          return

        .on 'error', (details...) ->
          element.off('load error')
          deferred.reject(details...)
          return

      element.attr(src: @url(options))

      deferred.promise()

    url: (options = {}) ->
      if options.width? and @attributes.preview_url?
        width = options.width
        width = Math.min(width, @attributes.width) if @attributes.width?
        width = Math.round(width)
        @attributes.preview_url.replace(/w\d+-h\d+(-p)?/, "w#{width}")

      else
        @attributes.url or @attributes.preview_url
