class Settings

  @@instance = nil

  def method
    'instance method'
  end

  class << self
    def instance
      @@instance ||= new
    end

    private

    def initialize
    end
  end
end
