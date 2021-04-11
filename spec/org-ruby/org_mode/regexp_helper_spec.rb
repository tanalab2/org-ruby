require 'spec_helper'
require_relative '../../../lib/org-ruby/org_mode/regexp_helper'

module OrgMode
  RSpec.describe RegexpHelper do
    describe '.headline?' do
      it 'returns the match array' do
        match = RegexpHelper.headline?('* Headline')
        expect(match['stars']).to eq '*'
        expect(match['todo']).to be_empty
        expect(match['entry']).to eq 'Headline'
      end

      it 'set match values' do
        match = RegexpHelper.headline?('* TODO Headline')
        expect(match['stars']).to eq '*'
        expect(match['todo']).to eq ' TODO'
        expect(match['entry']).to eq 'Headline'
      end
    end

    describe '.comment?' do
      it 'return the matching array' do
        match = RegexpHelper.comment?("# Comment")
        expect(match['bullet']).to eq '#'
        expect(match['entry']).to eq 'Comment'
      end

      example 'match values' do
        match = RegexpHelper.comment?("  ## This is a comment")
        expect(match['bullet']).to eq '  ##'
        expect(match['entry']).to eq 'This is a comment'
      end
    end
  end
end
