require_relative './regexp_helper'

module OrgMode
  # A document line
  class Line
    attr_reader :content

    def initialize(text)
      @content = text
    end

    def headline?(helper: OrgMode::RegexpHelper)
      helper.headline?(content)
    end

    def translate(translator: )
      translator.translate self
    end
  end
end
