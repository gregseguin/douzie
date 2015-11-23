xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
    xml.loc root_url
    xml.changefreq("hourly")
    xml.priority "1.0"
  end
  @tags.each do |tag|  
    xml.url do
      xml.loc tag_url(tag)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod tag.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  @jokes.each do |joke|  
    xml.url do
      xml.loc joke_url(joke)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod joke.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
end