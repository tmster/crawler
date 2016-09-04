# frozen_string_literal: true
class OtodomPage < Base
  attr_reader :url

  def title
    node.title
  end

  def short_title
    node
      .root
      .at_css('body > div.article-offer > section.section-offer-title > div > div > header > h1')
      .text
      .strip
  end

  def price
    node
      .root
      .at_css('body > div.article-offer > section.section-offer-title > div > div > div > div > strong')
      .text
      .scan(/\d/)
      .join('')
  end

  def additional_price
    additional_price_node = details_node
      .at_xpath('//text()[normalize-space() = \'czynsz - dodatkowo:\']')

    return unless additional_price_node

    additional_price_node
      .parent
      .parent
      .at_xpath('text()')
      .text
      .scan(/\d/)
      .join('')
  end

  def floor
    child_node = details_node
      .at_xpath('//text()[normalize-space() = \'piętro\']')

    child_node
      .parent
      .at_css('span strong')
      .text if child_node
  end

  def rooms
    node = details_node
      .at_xpath('//text()[normalize-space() = \'liczba pokoi\']|//text()[normalize-space() = \'liczba pokoi:\']')
      .parent

    node.at_css('span strong') ? node.at_css('span strong').text : node.parent.at_xpath('text()').text.strip
  end

  def size
    details_node
      .at_xpath('//text()[normalize-space() = \'powierzchnia\']')
      .parent
      .parent
      .css('span')
      .last
      .text.strip[0..-4].tr(',', '.').to_f
  end

  def location
    atrributes = node.root.at_css('#adDetailInlineMap').attributes
    "#{atrributes['data-lat']}, #{atrributes['data-lon']}"
  end

  def street
    node.root.at_css(".ad-map-location.ad-map-title").text.strip
  end

  def county
    "Powiat Kraków"
  end

  def city
    "Gmina " + address.split(', ')[0]
  end

  def district
    address.split(', ')[0] + " " + address.split(', ')[1]
  end

  def address
    location_node
      .split(' ')
      .drop(3)
      .join(' ')
      .split(' - ')[0..-2]
      .join(' - ')
  end

  def estate_type
    EstateTypeNormalizer.new(title.split(' - ').first.split(', ').last.strip).call
  end

  def offer_type
    OfferTypeNormalizer.new(title.split(' - ').first.split(', ').last.strip).call
  end

  private

  def details_node
    @details_node ||= node
                      .root
                      .at_xpath('//*[@class="section-offer-params"]/div/div/div/ul')
  end

  def location_node
    @location_node ||= node
                       .root
                       .at_xpath('//*[@class="section-offer-title"]/div/div/header/address/p[1]')
                       .text
                       .strip
  end
end
