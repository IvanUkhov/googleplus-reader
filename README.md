# GooglePlus Reader [![Gem Version](https://badge.fury.io/rb/googleplus-reader.svg)](http://badge.fury.io/rb/googleplus-reader)

A [jQuery](http://jquery.com)-based library for reading public posts
of a [Google+](https://plus.google.com) user. An example can be found
[here](http://ivanukhov.com). Best enjoyed responsibly.

## Installation

    $ echo "gem 'googleplus-reader'" >> Gemfile
    $ bundle install

The code is written in [CoffeeScript](http://coffeescript.org); however,
any dependencies in this regard are purposely omitted. So make sure you
have CoffeeScript installed.

## Usage

Here is an example in the context of a [Rails](http://rubyonrails.org)
application. First, we need CoffeeScript as it was noted earlier:

    $ echo "gem 'coffee-rails'" >> Gemfile
    $ bundle install

In your `app/views/layouts/application.html.haml`:
``` rails
= javascript_include_tag '//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js'
= javascript_include_tag :application
```

In your `app/assets/javascripts/application.js.coffee`:
``` coffee
//= require googleplus.reader

reader = new GooglePlus.Reader \
  id: 'user_id', key: 'api_key'

reader.next 5, (posts) ->
  console.log post for post in posts
```
Here `user_id` is the identifier of a Google+ user, and `api_key` is your
[Google+ API key](https://developers.google.com/+/api/oauth).
`post` is exactly what Google has to say about each post without any
additional preprocessing. You might want to inspect it and fetch what is
needed for your application.

A more interesting example with photos that a user publishes:
``` coffee
//= require googleplus.photoreader

reader = new GooglePlus.PhotoReader \
  id: 'user_id', key: 'api_key'

reader.next 5, (photos) ->
  console.log photo.attributes for photo in photos
```
`photo` is an instance of `GooglePlus.Photo`. Right now, `attributes`
contain only `url`, `date`, and `width` (if available), but other parameters
can be easily added via a pull request >:)~ The only method that `photo`
has is `load`, which can be used as follows:
``` coffee
photo.load {}, (element) ->
  $('#original').append element

photo.load width: 300, (element) ->
  $('#small').append element

photo.load width: 1000, (element) ->
  $('#large').append element

element = photo.load width: 2000
console.log element.attr('href')
$('#huge').append element
```
`load` constructs an URL referencing the photo of the desired size and
preloads it using an `img` element, which it returns right away and also
passes to the callback function once the photo has been loaded.


## Contributing

1. Fork it (https://github.com/IvanUkhov/googleplus-reader/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
