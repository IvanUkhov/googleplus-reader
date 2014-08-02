class Reader
  constructor: (options) ->
    @$ = jQuery

    @id = options.id
    @key = options.key
    @token = null
    @collection = []
    @position = 0

  next: (count) ->
    deferred = @$.Deferred()

    nextPosition = @position + count

    if nextPosition <= @collection.length
      elements = @collection.slice(@position, nextPosition)
      @position = nextPosition
      deferred.resolve(elements)

    else
      @load()
        .done =>
          nextPosition = Math.min(nextPosition, @collection.length)
          elements = @collection.slice(@position, nextPosition)
          @position = nextPosition
          deferred.resolve(elements)
          return

        .fail (details...) =>
          deferred.reject(details...)
          return

    deferred

  load: ->
    url = "https://www.googleapis.com/plus/v1/people/#{@id}/activities/public?key=#{@key}"
    url = "#{url}&pageToken=#{@token}" if @token

    @$.ajax(url: url, crossDomain: true, dataType: 'jsonp').done (result) =>
      @append(result.items)
      @token = result.nextPageToken
      return

  append: (items) ->
    @collection.push(item) for item in items
    return

window.GooglePlus ||= {}
window.GooglePlus.Reader = Reader
