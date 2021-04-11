require 'spec_helper'
require_relative '../../../lib/org-ruby/org_mode/document'

module OrgMode
  # Represent a org document
  RSpec.describe Document do
    let(:text) { "This is the content of document." }
    let(:document) { Document.new(text) }
    describe '.new' do
      it 'receives a string as text for content' do
        expect(document.content).to eq text
      end
    end

    describe 'headlines' do
      let(:headlines_content) { ['* Headline 1', '* Headline 2'] }

      it 'returns headlines from documents' do
        headlines = document.headlines
        content = headlines.map &:content
        expect(contente).to match_array headlines_content
      end
    end

    describe 'to_html' do
    end
  end
end
