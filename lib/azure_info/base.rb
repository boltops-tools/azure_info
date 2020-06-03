module AzureInfo
  class Base
    def check_az_installed!
      installed = system("type az > /dev/null 2>&1")
      return if installed
      raise Error.new("ERROR: az is not installed. Please install the az command.")
    end
  end
end
