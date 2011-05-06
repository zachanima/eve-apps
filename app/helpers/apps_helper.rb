module AppsHelper
  def generate_json(types)
    update = false
    types.each do |type|
      unless InvType.find_by_type_id type
        InvType.create!(:type_id => type)
        update = true
      end
    end
    update_values(types) if update

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
