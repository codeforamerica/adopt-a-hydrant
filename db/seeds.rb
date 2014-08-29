trees_file_path = Rails.root.join('db', 'trees.json')
trees_file      = File.read(trees_file_path)
trees_hash      = JSON.parse(trees_file)

# this is a weird nested hash
trees_meta = trees_hash["meta"]
# this is just a huge array
trees_data = trees_hash["data"]
# this is an array of all the field names
tree_fields = trees_meta['view']['columns'].map do |column|
  column['fieldName']
end

trees_data.each do |tree|
  Thing.find_or_create_by!(city_id: tree[8]) do |t|
    t.properties = {}
    tree_fields.map.with_index do |f, index|
      t.properties[tree_fields[index]] = tree[index]
    end

    t.city_unique_id = tree[9]
    t.lon = tree[64]
    t.lat = tree[65]
    t.species = tree[66]
  end
end
