require 'sinatra'

#require 'sinatra/reloader' if development?
set :environment, :production

require 'slim'
require 'sass'
require 'rack-livereload'
require './lib/soma2'
require './lib/player'
require 'yaml'

use Rack::LiveReload

def soma
  data = YAML.load_file 'soma.yaml'
  Soma.new data['soma']
end

get '/' do
  @soma = soma
  slim :index
end

post '/play/:channel' do
  id = params[:channel]

  channel = soma.channels.find { |x|
    x.id == id
  }

  Player.play channel

  'ok?'
end


__END__

@@ layout
doctype 5
html
  head
    title Soma fm
    sass:
      html
        background-color: black
      *
        margin: 0
        padding: 0
      .channels
        margin: 0
        padding: 0
      .channels__channel
        //width: 200px
        //height: 200px
        //border: solid gray 1px
        float: left
        .cover
          display: block

  body
    == yield


@@ index
.channels
  - @soma.channels.each do |channel|
    .channels__channel id=channel.id
      /= channel.name
      img.cover src=channel.img

coffee:

  playChannel = (channel)->
    r = new XMLHttpRequest()
    r.open 'POST', "play/#{ channel }", true
    #r.onreadystatechange = ->
    #  return if (r.readyState != 4 || r.status != 200)
    #  alert "Success: #{ r.responseText }"
    r.send ''

  window.onload = ->
    chans = document.querySelectorAll('.channels__channel')
    for channel in chans
      channel.onclick = (e)->
        # assume click on image, not channel itself...
        id = e.target.parentNode.id
        playChannel id
        false
