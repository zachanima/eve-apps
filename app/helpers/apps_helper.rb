module AppsHelper
  def generate_json(types)
    InvType.find_all_by_type_id(types).collect do |type|
  "#{type.type_id}: {
    volume: #{type.volume},
    buy: #{type.buy || 0},
    sell: #{type.sell || 0}
  },
  "
    end.join
  end
end
