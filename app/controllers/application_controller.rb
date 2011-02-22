require 'net/http'
require 'rexml/document'

class ApplicationController < ActionController::Base
  protect_from_forgery

  def update_values(types)
    inv_types = InvType.find_all_by_type_id(types.sort)

    types = inv_types.collect do |type|
      type.type_id if Time.now - 1.day > type.updated_at
    end.flatten.compact

    @updates = types.length

    if types
      url = [
        'http://api.eve-central.com/api/marketstat?typeid=',
        types.join('&typeid='),
        '&usesystem=',
        30002659
      ].join

      sell = Array.new
      buy = Array.new
      
      data = Net::HTTP.get_response(URI.parse(url)).body
      REXML::Document.new(data).elements.each('/evec_api/marketstat/type/sell/median') do |item|
        sell << item.to_s.gsub(/[^0-9\.]/, '').to_f
      end
      REXML::Document.new(data).elements.each('/evec_api/marketstat/type/buy/median') do |item|
        buy << item.to_s.gsub(/[^0-9\.]/, '').to_f
      end

      sell.each_index do |i|
        type = InvType.find_by_type_id(types[i])
        type.sell = sell[i]
        type.buy = buy[i]
        type.save
      end
    end
  end
end
