module Mail
  module VERSION

    MAJOR = 2
    MINOR = 6
    PATCH = 3
    BUILD = 'tdm7'

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')

    def self.version
      STRING
    end

  end
end
