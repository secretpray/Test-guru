
module TestGuru
  VERSION = '0.1.0'.freeze

  def self.version
    "v#{self.read_version}"
  end

def self.read_version
  begin
    File.read 'VERSION'
  rescue
    raise "VERSION file not found or unreadable."
  end
end

  # def self.version
  #   VERSION
  # end
end
