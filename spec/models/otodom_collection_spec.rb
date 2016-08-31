# frozen_string_literal: true
require 'spec_helper'

RSpec.describe OtodomCollection do
  let(:url) { double }

  subject { described_class.new(url) }

  describe 'methods' do
    it { expect(subject).to respond_to(:items) }
    it { expect(subject).to respond_to(:next_page) }
    it { expect(subject).to respond_to(:current_page) }
    it { expect(subject).to respond_to(:pages) }
    it { expect(subject).to respond_to(:next_page_anchor) }
  end

  describe '#next_page_anchor' do
    context 'last page' do
      before do
        expect(subject)
            .to receive(:next_page)
                    .and_return(nil)
      end

      it 'returns nil' do
        expect(subject.next_page_anchor).to be_nil
      end
    end

    context 'returns new page' do
      let(:url) { 'https://otodom.pl/wynajem/mieszkanie/krakow/?search%5Bdescription%5D=1&search%5Bdist%5D=0' }

      before do
        expect(subject)
            .to receive(:next_page)
                    .and_return(2)
                    .twice
      end

      it 'returns new page' do
        expect(subject.next_page_anchor)
            .to eq 'https://otodom.pl/wynajem/mieszkanie/krakow/?search%5Bdescription%5D=1&search%5Bdist%5D=0&page=2'
      end
    end
  end

  describe '#parse_urls' do
    let(:url2) { double }
    let(:urls) { [url, url2] }

    before do
      expect(subject)
          .to receive(:collect_urls)
                  .and_return(urls)
    end

    it 'returns array of instances' do
      expect(subject.send(:parse_urls).map(&:class)).to eq [OtodomPage, OtodomPage]
    end
  end
end
