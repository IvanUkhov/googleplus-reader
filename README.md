# GooglePlus Reader [![Gem Version](https://badge.fury.io/rb/googleplus-reader.svg)](http://badge.fury.io/rb/googleplus-reader)

A library for reading public posts of a [Google+](https://plus.google.com)
user. A life demo can be found [here](http://photography.ivanukhov.com) and its
source code [here](https://github.com/IvanUkhov/photography). Best enjoyed
responsibly.

## Installation

In `Gemfile`:

```ruby
gem 'googleplus-reader'
```

In terminal:

```bash
$ bundle
```

The code is written in [CoffeeScript](http://coffeescript.org) and relies on
[jQuery](http://jquery.com); however, all dependencies in this regard are
purposely omitted. So make sure you have a proper setup (see below).

## Usage

Here is an example in the context of a [Rails](http://rubyonrails.org)
application.

In `Gemfile`:

```ruby
gem 'coffee-rails'
```

In terminal:

```bash
$ bundle
```

In `app/views/layouts/application.html.haml`:

```haml
= javascript_include_tag '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js'
= javascript_include_tag :application
```

In `app/assets/javascripts/application.js.coffee`:

```coffee
//= require googleplus.reader

reader = new GooglePlus.Reader(id: 'user_id', key: 'api_key')

reader.next(5).done (posts) ->
  console.log(post) for post in posts
```

Here `user_id` is the identifier of a Google+ user, and `api_key` is your
[Google+ API key](https://developers.google.com/+/api/oauth). `post` is exactly
what Google has to say about each post without any additional preprocessing.
You might want to inspect it and fetch what is needed for your application.

A more interesting example with photos that a user publishes:

```coffee
//= require googleplus.photo
//= require googleplus.reader
//= require googleplus.photoreader

reader = new GooglePlus.PhotoReader(id: 'user_id', key: 'api_key')

reader.next(5).done (photos) ->
  console.log(photo.attributes) for photo in photos
```

`photo` is an instance of `GooglePlus.Photo`. Right now, `attributes` contains
only `url`, `date`, and `width` (if available), but other parameters can be
easily added via a pull request >:)~ The only method that `photo` has is
`load`, which can be used as follows:

```coffee
photo.load().done (element) ->
  $('#original').append(element)

photo.load(width: 300).done (element) ->
  $('#small').append(element)

photo.load(width: 1000).done (element) ->
  $('#large').append(element)
```

`load` constructs an URL referencing the photo of the desired size and preloads
it using an `img` element, which is passes to `done` once the photo has been
loaded.

## Contributing

1. [Fork](https://help.github.com/articles/fork-a-repo) the project.
2. Create a branch for your feature (`git checkout -b awesome-feature`).
3. Implement your feature (`vim`).
4. Commit your changes (`git commit -am 'Implemented an awesome feature'`).
5. Push to the branch (`git push origin awesome-feature`).
6. [Create](https://help.github.com/articles/creating-a-pull-request)
   a new Pull Request.
