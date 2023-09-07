require('./photo_handler')

class PhotosList
  include PhotoHandler

  attr_reader :photos

  def initialize(list)
    @photos = list.split("\n")
  end

  def organize
    city_groups = group_by_city
    city_groups = assign_numbers_and_rename(city_groups)

    photo_names_list = extract_names(city_groups)
    photo_names_list.join("\n")
  end

  private

  def group_by_city
    city_groups = Hash.new { |hash, key| hash[key] = [] }

    photos.each_with_index do |photo, idx|
      name, city, timestamp = photo.split(', ')

      city_groups[city] << [idx, name, timestamp]
    end

    city_groups
  end

  def assign_numbers_and_rename(city_groups)
    city_groups.each do |city, photo_list|
      photo_list.sort_by! { |(_, _, timestamp)| timestamp }

      photo_list.each_with_index do |photo, index|
        idx, _, timestamp = photo
        new_name = construct_name(city_groups, city, photo, index)

        city_groups[city][index] = [idx, new_name, timestamp]
      end
    end

    city_groups
  end
end
