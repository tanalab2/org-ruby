require_relative './line'

module OrgMode
  # represent a org document
  class Document
    attr_reader :content

    def initialize(text)
      @content = text
    end

    def headlines
      lines.filter(&:headline?)
    end

    def to_html
      translator = OrgMode::HtmlTranslator
      lines.map do |line|
        line.translate(translator: translator)
      end
    end

    private

    def lines
      @lines ||= content.split("\n").map { |line| Line.new(line) }
    end
  end
end
