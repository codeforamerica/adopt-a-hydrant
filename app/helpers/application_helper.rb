module ApplicationHelper
  def us_states # rubocop:disable MethodLength
    [
      ['Massachusetts', 'MA'],
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY'],
    ]
  end

  def dimensions(dimension)
    "#{dimension}x#{dimension}"
  end

  def favicon_path(file)
    image_path "logos/favicons/#{file}?v=#{Rails.application.config.assets.version}"
  end

  def favicon_attrs(rel, type = 'image/png')
    {rel: rel, type: type}
  end

  def namespaced_png_favicon_path(namespace, dimension)
    favicon_path("#{namespace}-#{dimensions(dimension)}.png")
  end

  def namespaced_png_favicon_link_tag(namespace, dimension, rel)
    favicon_link_tag namespaced_png_favicon_path(namespace, dimension), favicon_attrs(rel).merge(sizes: dimensions(dimension))
  end

  def namespaced_png_favicon_link_tags(namespace, dimensions, rel = 'icon')
    safe_join dimensions.map { |dimension| namespaced_png_favicon_link_tag(namespace, dimension, rel).html_safe }
  end
end
