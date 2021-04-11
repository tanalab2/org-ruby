require 'spec_helper'
require_relative '../../../lib/org-ruby/org_mode/line'

module OrgMode
  RSpec.describe Line do
    let(:text) { 'This is a line' }
    let(:line) { Line.new text }
    describe '.new' do
      it 'has a content from the text it receives' do
        expect(line.content).to eq text
      end
    end

    describe '#headline?' do
      context 'when the content of the line starts with *' do
        let(:headline) { Line.new '* Headline' }
        it 'is a headline' do
          expect(headline).to be_headline
        end
      end
      context 'other case' do
        let(:headline) { Line.new 'Not *A* Headline'}
        it 'is not a headline' do
          expect(headline).not_to be_headline
        end
      end
    end
  end
end
