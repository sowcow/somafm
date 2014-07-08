require_relative 'page'
require 'yaml' # soma::serializable


class Soma
  include Page; URL = 'http://somafm.com'

  def channels
    body.css('#stations ul li').map { |node|
      Channel.new url, node
    }
  end

  def at
    Time.now
  end
end


class Soma::Serializable < Soma
  def to_yaml
    string_hash.to_yaml
  end
  
  def to_h
    {
      soma: {
        at: at,
        channells: channels.map(&:to_h)
      }
    }
  end

  private

  def string_hash
    #to_h.inject({}){|memo,(k,v)| memo[String(k)] = v; memo}
    hash = to_h
    symbolize_keys_deep! hash
    hash
  end

  def symbolize_keys_deep!(h)
    h.keys.each { |k|
      ks    = String k #.to_sym
      h[ks] = h.delete k

      case child = h[ks] 
      when Hash then symbolize_keys_deep! child
      when Array
        child.map { |x| symbolize_keys_deep! x }
      end
    }
  end

end


class Soma::Channel < Struct.new :root, :node
  include Page

  def pls
    relative = node.at('a[href]')[:href]
    [root, relative].join.sub /\/$/, '.pls'
  end

  def img
    relative = node.at('a[href] > img')[:src]
    [root, relative].join
  end

  def name
    node.at('h3').text
  end

  def desc
    node.at('p.descr').text
  end

  def to_h
    {
      name:  name,
      desc:  desc,
      img:   img,
      pls:   pls,
    }
  end

end
