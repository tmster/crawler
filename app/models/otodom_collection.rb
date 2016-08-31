# frozen_string_literal: true
require 'cgi'

class OtodomCollection < Base
  def items
    parse_urls
  end

  def next_page
    current_page + 1 if current_page < pages
  end

  def current_page
    node
      .root
      .at_xpath('//*[@id="pageParam"]')
      .attributes['placeholder']
      .value
      .to_i
  end

  def pages
    node
      .root
      .at_xpath('//*[@id="pagerForm"]/ul/li/strong')
      .text
      .to_i
  end

  def next_page_anchor
    return unless next_page
    url_support = UrlSupport.new(url)
    url_support.override_query_variable('page', next_page)
    url_support.to_s
  end

  private

  def parse_urls
    collect_urls.map do |url|
      OtodomPage.new(url)
    end
  end

  def collect_urls
    node.root.xpath('//*[@id="body-container"]/div/div/div[2]/div/article/div[1]/header/h3/a').map do |element|
      if element['href'][0] == '/'
        "https://otodom.pl#{element['href']}"
      else
        element['href']
      end
    end
  end
end
