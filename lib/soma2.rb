require 'virtus'

class Channel
  include Virtus.model

  attribute :name, String
  attribute :desc, String
  attribute :id,  String
  attribute :img,  String
  attribute :pls,  String
end

class Soma
  include Virtus.model

  attribute :at, DateTime
  attribute :channels, Array[Channel]
end


if __FILE__ == $0
  data = {
    at: Time.now,
    channels: [
      { name: 'Hey!' }
    ]
  }
  p Soma.new(data).channels
end
