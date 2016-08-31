# frozen_string_literal: true
require 'spec_helper'

RSpec.describe OtodomPage do
  let(:url) { double }

  subject { described_class.new(url) }

  describe 'methods' do
    it { expect(subject).to respond_to(:title) }
    it { expect(subject).to respond_to(:short_title) }
    it { expect(subject).to respond_to(:price) }
    it { expect(subject).to respond_to(:additional_price) }
    it { expect(subject).to respond_to(:floor) }
    it { expect(subject).to respond_to(:rooms) }
    it { expect(subject).to respond_to(:location) }
    it { expect(subject).to respond_to(:street) }
    it { expect(subject).to respond_to(:county) }
    it { expect(subject).to respond_to(:city) }
    it { expect(subject).to respond_to(:district) }
    it { expect(subject).to respond_to(:address) }
  end
end
