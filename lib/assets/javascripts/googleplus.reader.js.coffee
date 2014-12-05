unless typeof define is 'function' and define.amd
  module = @GooglePlus ||= {}
  @define = (name, deps, callback) ->
    module.Reader = callback(jQuery)

define 'googleplus.reader', ['jquery'], ($) ->
  class
    constructor: (options) ->
      @id = options.id
      @key = options.key
      @reset()

    reset: ->
      @token = null
      @collection = []
      @position = 0
      return

    find: (id) ->
      deferred = $.Deferred()

      @get(id)
        .done (result) =>
          deferred.resolve(@process([result]))
          return

        .fail (details...) =>
          deferred.reject(details...)
          return

      deferred.promise()

    next: (count) ->
      deferred = $.Deferred()

      nextPosition = @position + count

      if nextPosition <= @collection.length
        elements = @collection.slice(@position, nextPosition)
        @position = nextPosition
        deferred.resolve(elements)

      else
        @list()
          .done (result) =>
            @collection.push(item) for item in @process(result.items)
            nextPosition = Math.min(nextPosition, @collection.length)
            elements = @collection.slice(@position, nextPosition)
            @position = nextPosition
            deferred.resolve(elements)
            return

          .fail (details...) =>
            deferred.reject(details...)
            return

      deferred.promise()

    get: (id) ->
      url = "https://www.googleapis.com/plus/v1/activities/#{id}?key=#{@key}"
      $.ajax(url: url, crossDomain: true, dataType: 'jsonp')

    list: ->
      url = "https://www.googleapis.com/plus/v1/people/#{@id}/activities/public?key=#{@key}"
      url = "#{url}&pageToken=#{@token}" if @token
      $.ajax(url: url, crossDomain: true, dataType: 'jsonp').done (result) =>
        @token = result.nextPageToken
        return

    process: (items) ->
      items
