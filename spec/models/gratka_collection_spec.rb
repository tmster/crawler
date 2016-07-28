require 'spec_helper'

RSpec.describe GratkaCollection do
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
      let(:url) { 'http://dom.gratka.pl/mieszkania/krakow/wynajem/' }

      before do
        expect(subject)
          .to receive(:next_page)
          .and_return(2)
          .twice
      end

      it 'returns new page' do
        expect(subject.next_page_anchor)
          .to eq 'http://dom.gratka.pl/mieszkania/krakow/wynajem/?s=2'
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
      expect(subject.send(:parse_urls).map(&:class)).to eq [GratkaPage, GratkaPage]
    end
  end
end
