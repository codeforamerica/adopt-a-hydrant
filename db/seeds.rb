trees_file_path = Rails.root.join('db', 'trees.json')
trees_file = File.read(trees_file_path)
trees_hash = JSON.parse(trees_file)

# this is a weird nested hash
trees_meta = trees_hash["meta"]
# this is just a huge array
trees_data = trees_hash["data"]

