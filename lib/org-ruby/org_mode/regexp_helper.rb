module OrgMode
  module RegexpHelper
    def self.headline?(line)
      headline_regexp = /^(?<stars>[\*]+)(?<todo>[\s\w]*)\s+(?<entry>.*)/
      headline_regexp.match(line)
      Regexp.last_match
    end

    def self.comment?(line)
      comment_regexp = /^(?<bullet>\s*[#]+)\s+(?<entry>.*)/
      comment_regexp.match(line)
      Regexp.last_match
    end
  end
end
