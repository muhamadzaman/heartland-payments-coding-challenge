module PhotoHandler
  private

  def construct_name(city_groups, city, photo, index)
    max_length = city_groups[city].size.to_s.length
    _, name = photo
    natural_number = (index + 1).to_s.rjust(max_length, '0')

    "#{city}#{natural_number}.#{name.split('.').last}"
  end

  def extract_names(city_groups)
    new_list = city_groups.values.flat_map do |group|
      group.map { |idx, name| [idx, name] }
    end

    new_list.sort_by!(&:first).map!(&:last)

    new_list
  end
end
