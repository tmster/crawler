# frozen_string_literal: true
require 'spec_helper'

RSpec.describe OtodomCollection do
  include_context 'parser file helpers', 'otodom'

  let(:url) { 'https://otodom.pl/wynajem/mieszkanie/krakow/?search%5Bdescription%5D=1&search%5Bdist%5D=0' }
  let(:url2) { 'https://otodom.pl/wynajem/mieszkanie/krakow/?search%5Bdescription%5D=1&search%5Bdist%5D=0&page=2' }
  let(:url3) { 'https://otodom.pl/sprzedaz/mieszkanie/krakow/?search%5Bdescription%5D=1&search%5Bdist%5D=0' }

  before do
    setup_data('otodom')
    FakeWeb
      .register_uri(
        :get,
        url,
        body: read_data('collection', 1),
        content_type: 'text/html'
      )
    FakeWeb
      .register_uri(
        :get,
        url2,
        body: read_data('collection', 2),
        content_type: 'text/html'
      )
    FakeWeb
      .register_uri(
        :get,
        url3,
        body: read_data('collection', 3),
        content_type: 'text/html'
      )
  end

  describe '#items' do
    it 'returns instances' do
      expect(described_class.new(url).items.count).to eq 27
    end
  end

  describe '#collect_urls' do
    it 'returns instances' do
      expect(described_class.new(url).send(:collect_urls).count).to eq 27
    end

    it 'first element match to mock' do
      expect(described_class.new(url).send(:collect_urls).first)
        .to eq 'https://otodom.pl/oferta/mieszkanie-100m-z-ogrodem-osiedle-fajny-dom-ID33l36.html#da0f5b7a54'
    end

    it 'last element match to mock' do
      expect(described_class.new(url).send(:collect_urls).last)
        .to eq 'https://otodom.pl/oferta/mieszkanie-stare-miasto-dla-studentow-lub-firm-ID33vOu.html#da0f5b7a54'
    end
  end

  describe '#current_page' do
    context 'rentals' do
      it { expect(described_class.new(url).current_page).to eq 1 }
      it { expect(described_class.new(url2).current_page).to eq 2 }
    end

    context 'real estate' do
      it { expect(described_class.new(url3).current_page).to eq 1 }
    end
  end

  describe '#next_page' do
    context 'rentals' do
      it { expect(described_class.new(url).next_page).to eq 2 }
      it { expect(described_class.new(url2).next_page).to eq 3 }
    end

    context 'real estate' do
      it { expect(described_class.new(url3).next_page).to eq 2 }
    end
  end

  describe '#pages' do
    context 'rentals' do
      it { expect(described_class.new(url).pages).to eq 224 }
      it { expect(described_class.new(url2).pages).to eq 224 }
    end

    context 'real estate' do
      it { expect(described_class.new(url3).pages).to eq 1399 }
    end
  end
end
