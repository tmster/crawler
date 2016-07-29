# frozen_string_literal: true
class GratkaPage < Base
  attr_reader :url

  def title
    node.title
  end

  def short_title
    node
      .root
      .at_css('#karta-naglowek > div:nth-child(1) > div > h1')
      .text
      .strip
  end

  def price
    node
      .root
      .at_xpath('//*[@id="karta-ogloszenia"]/div/div[2]/div[1]/p/b')
      .text
      .scan(/\d/)
      .join('')
  end

  def additional_price
    child_node = node
                 .root
                 .at_xpath('//*[@id="karta-ogloszenia"]/div/div[2]/div[1]/ul')
                 .at_xpath('//text()[normalize-space() = \'opłaty:\']')

    child_node.parent.at_css('b').text if child_node
  end

  def floor
    details_node
      .at_xpath('//text()[normalize-space() = \'Piętro\']')
      .parent
      .parent
      .at_css('div')
      .text
  end

  def rooms
    details_node
      .at_xpath('//text()[normalize-space() = \'Liczba pokoi\']')
      .parent
      .parent
      .at_css('div')
      .text
  end

  def size
    details_node
      .at_xpath('//text()[normalize-space() = \'Powierzchnia\']')
      .parent.parent.at_css('div').text.strip[0..-4].tr(',', '.').to_f
  end

  def location
    node.root.css('#zak-mapa > script').text.match(/LatLng\((.*?)\)/)[1]
  end

  def street
    short_title.split(', ')[1]
  end

  def county
    address.split(', ')[2]
  end

  def city
    address.split(', ')[3]
  end

  def district
    short_title.split(', ').first.split(' ').drop(1).join(' ')
  end

  def address
    location_node
      .split(' ')
      .drop(3)
      .join(' ')
  end

  def type
    location_node.split(' ')[0..2].join('')
  end

  private

  def details_node
    @details_node ||= node
                      .root
                      .at_xpath('//*[@id="dane-podstawowe"]/div/div[2]/ul')
  end

  def location_node
    @location_node ||= node
                       .root
                       .at_css('#karta-naglowek > div:nth-child(1) > div > h2')
                       .text
                       .strip
  end
end
