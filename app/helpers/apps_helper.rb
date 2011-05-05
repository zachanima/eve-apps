module AppsHelper
  def generate_json(types)
    types.each do |type|
      unless InvType.exists? type
        InvType.create!(:type_id => type)
      end
    end

    InvType.find_all_by_type_id(types).collect do |type|
  "#{type.type_id}: {
    volume: #{type.volume || 0},
    buy: #{type.buy || 0},
    sell: #{type.sell || 0}
  },
  "
    end.join
  end
end
