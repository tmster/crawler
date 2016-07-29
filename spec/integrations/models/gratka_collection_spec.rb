# frozen_string_literal: true
require 'spec_helper'

RSpec.describe GratkaCollection do
  include_context 'parser file helpers'

  let(:url) { 'http://dom.gratka.pl/mieszkania/krakow/wynajem/' }
  let(:url2) { 'http://dom.gratka.pl/mieszkania/krakow/wynajem/?s=2' }

  before do
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
  end

  describe '#items' do
    it 'returns instances' do
      expect(described_class.new(url).items.count).to eq 40
    end
  end

  describe '#collect_urls' do
    it 'returns instances' do
      expect(described_class.new(url).send(:collect_urls).count).to eq 40
    end

    it 'first element match to mock' do
      expect(described_class.new(url).send(:collect_urls).first)
        .to eq 'http://dom.gratka.pl/tresc/401-69154375-malopolskie-krakow-podgorze-nadwislanska.html'
    end

    it 'last element match to mock' do
      expect(described_class.new(url).send(:collect_urls).last)
        .to eq 'http://dom.gratka.pl/tresc/401-69126225-malopolskie-krakow-al-kijowska.html'
    end
  end

  describe '#current_page' do
    context 'rentals' do
      it { expect(described_class.new(url).current_page).to eq 1 }
    end

    context 'real estate' do
      it { expect(described_class.new(url2).current_page).to eq 1 }
    end
  end

  describe '#next_page' do
    context 'rentals' do
      it { expect(described_class.new(url).next_page).to eq 2 }
    end

    context 'real estate' do
      it { expect(described_class.new(url2).next_page).to eq 2 }
    end
  end

  describe '#pages' do
    context 'rentals' do
      it { expect(described_class.new(url).pages).to eq 206 }
    end

    context 'real estate' do
      it { expect(described_class.new(url2).pages).to eq 885 }
    end
  end
end
