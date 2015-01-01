# DESCRIPTION:

This is the oembed_links gem, updated to work in Rails 3.  It allows you to easily parse text and
query configured providers for embedding information on the links
inside the text. A sample configuration file for configuring the
library has been included (`oembed_links_example.yml`), though you
may also configure the library programmatically (see rdocs).

# REQUIREMENTS:

You must have the JSON gem installed to use oembed_links.
I've removed support for XML and templates. All providers must use JSON.

# SYNOPSIS:

To get started quickly (in irb):

``` ruby
require 'oembed_links'
OEmbed.register({:method => "NetHTTP"},
                {:flickr => "http://www.flickr.com/services/oembed/",
                 :vimeo => "http://www.vimeo.com/api/oembed.{format}"},
                {:flickr => { :format => "json", :schemes => ["http://www.flickr.com/photos/*"]},
                 :vimeo => { :format => "json", :schemes => ["http://www.vimeo.com/*"]}})
```

# Simple transformation
``` ruby
OEmbed.transform("This is my flickr URL http://www.flickr.com/photos/bees/2341623661/ and all I did was show the URL straight to the picture")
```

# More complex transformation
``` ruby
OEmbed.transform("This is my flickr URL http://www.flickr.com/photos/bees/2341623661/ and this is a vimeo URL http://www.vimeo.com/757219 wow neat") do |r, url|
  r.audio? { |a| "It's unlikely flickr or vimeo will give me audio" }
  r.photo? { |p| "<img src='#{p["url"]}' alt='Sweet, a photo named #{p["title"]}' />" }
  r.from?(:vimeo) { |v| "<div class='vimeo'>#{v['html']}</div>" }
end
```

# Transformation to drive Amazon links to our department affiliate code
``` ruby
OEmbed.register_provider(:oohembed,
                         "http://oohembed.com/oohembed/",
                         "json",
                         "http://*.amazon.(com|co.uk|de|ca|jp)/*/(gp/product|o/ASIN|obidos/ASIN|dp)/*",
                         "http://*.amazon.(com|co.uk|de|ca|jp)/(gp/product|o/ASIN|obidos/ASIN|dp)/*")
OEmbed.transform("Here is a link to amazon http://www.amazon.com/Complete-Aubrey-Maturin-Novels/dp/039306011X/ref=pd_bbs_sr_2 wow") do |res, url|
    res.matches?(/amazon/) { |d|
      unless url =~ /(&|\?)tag=[^&]+/i
        url += ((url.index("?")) ? "&" : "?")
        url += "tag=wwwindystarco-20"
      end
      <<-EOHTML
        <div style="text-align:center;">
          <a href='#{url}' target='_blank'>
            <img src='#{d['thumbnail_url']}' border='0' /><br />
            #{d['title']} #{"<br />by #{d['author']}" if d['author']}
          </a>
        </div>
      EOHTML
    }
end
```

# To get started quickly in Rails:

Copy the included `oembed_links_example.yml` file to `Rails.root/config/oembed_links.yml`,
add a dependency to the gem in your Gemfile ( `gem "oembed_links"` )
and add the following to an initializer:

``` ruby
require 'oembed_links'

yaml_file = File.join(Rails.root, "config", "oembed_links.yml")
if File.exists?(yaml_file)
  OEmbed::register_yaml_file(yaml_file)
end
```


Then start your server.  That's it.  


# LICENSE:

(The MIT License)

Copyright (c) 2008 Indianapolis Star

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
