
module OrgMode
  module Translator
    def self.translate(line)
      constructor = infer_constructor(line)
      constructor.new(line)
    end

    private

    def self.infer_constructor(line)
      case line
      when comment?
        return HtmlCommentLine
      else
        return HtmlLine
      end
    end
  end
end
