require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'sass'
require 'rack-livereload'

use Rack::LiveReload

get '/' do
  slim :index
end

__END__

@@ layout
doctype 5
html
  head
    title Soma fm
    sass:
      *
        border: solid green 1px
  body
    == yield


@@ index
div.title Hey!
