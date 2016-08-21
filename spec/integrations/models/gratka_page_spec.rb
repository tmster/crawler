# frozen_string_literal: true
require 'spec_helper'

RSpec.describe GratkaPage do
  include_context 'parser file helpers'

  PAGES = YAML
          .load_file("#{Dir.pwd}/spec/fixtures/integration/gratka/pages.yml")

  shared_examples_for 'check parser methods' do |page, index, url|
    before do
      setup_data('gratka')
      FakeWeb
        .register_uri(
          :get,
          url,
          body: read_data('page', index),
          content_type: 'text/html'
        )
    end

    subject { described_class.new(url) }

    describe '#to_h' do
      it { expect(subject.to_h.keys).to eq page.keys }
      it { expect(subject.to_h).to eq page }
    end

    page.keys.each do |method|
      describe "##{method}" do
        it { expect(subject.public_send(method)).to eq page[method] }
      end
    end
  end

  PAGES.each_with_index do |page, index|
    it_behaves_like 'check parser methods', page, index + 1, page[:url]
  end
end
