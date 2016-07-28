# frozen_string_literal: true
class GratkaPage < Base
  def title
    node.title
  end

  def short_title
    node.root.css('#karta-naglowek > div:nth-child(1) > div > h1').first.text.strip
  end

  def price
    node
      .root
      .at_css('#karta-ogloszenia > div > div.small-12.large-4.columns > div.cenaGlowna > p > b')
      .text
      .scan(/\d/)
      .join('')
  end

  def additional_price
    node
      .root
      .at_css('#karta-ogloszenia > div > div.small-12.large-4.columns > div.cenaGlowna > ul > li:nth-child(2) > b')
      .text
  end

  def floor
    node
      .root
      .at_css('#dane-podstawowe > div > div.mieszkanie > ul > li:nth-child(2) > div')
      .text
  end

  def rooms
    node
      .root
      .at_css('#dane-podstawowe > div > div.mieszkanie > ul > li:nth-child(3) > div')
      .text
  end

  def location
    node.root.css('#zak-mapa > script').text.match(/LatLng\((.*?)\)/)[1]
  end

  def street
    address.split(', ')[1]
  end

  def county
    address.split(', ')[2]
  end

  def city
    address.split(', ')[3]
  end

  def district
    address.split(', ').first
  end

  def address
    node
      .root
      .at_css('#karta-naglowek > div:nth-child(1) > div > h2')
      .text
      .strip
      .split(' ')
      .drop(3)
      .join(' ')
  end

  def url
    @url
  end
end
