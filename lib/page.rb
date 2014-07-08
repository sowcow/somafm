require 'nokogiri'
require 'open-uri'
require 'memoizable'


module Page
  private
  def url; self.class::URL end

  def html
    open(url).read
  end

  def doc
    Nokogiri.HTML html
  end

  def body
    doc.at 'body'
  end

  include Memoizable
  memoize :html, :doc, :body
end


__END__
class SomaPlaylists
  include Page
  def url; 'http://somafm.com' end

  def self.all; new.all end

  def all
    channels = body.css('#stations ul li').map { |li|
      a = li.at('a[href]')
      p 1
      Channel.new url, a[:href]
    }

    channels.map &:channel_url
  end


  include Memoizable
  memoize :all
end


class Channel < Struct.new :url, :page
  include Page

  def channel_url
    p [url, page].join.sub /\/$/, '.pls'
  end
end
