# frozen_string_literal: true
require 'cgi'

class GratkaCollection < Base
  def items
    parse_urls
  end

  def next_page
    current_page + 1 if current_page < pages
  end

  def current_page
    node
      .root
      .at_css('#ogloszenia > div > div.row.marginGMaly.marginDMaly > div > ul > li > a.strona.aktywny')
      .text
      .to_i
  end

  def pages
    node
      .root
      .css('#ogloszenia > div > div.row.marginGMaly.marginDMaly > div > ul > li > a').map do |elem|
        elem.text.to_i
      end.compact.max
  end

  def next_page_anchor
    return unless next_page
    url_support = UrlSupport.new(url)
    url_support.override_query_variable('s', next_page)
    url_support.to_s
  end

  private

  def parse_urls
    collect_urls.map do |url|
      GratkaPage.new(url)
    end
  end

  def collect_urls
    node.root.xpath('//*[@id="list-ads"]/li/a').map do |element|
      if element['href'][0] == '/'
        "http://dom.gratka.pl#{element['href']}"
      else
        element['href']
      end
    end
  end
end
