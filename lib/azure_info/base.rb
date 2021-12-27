module AzureInfo
  class Base
    def check_az_installed!
      installed = system("type az > /dev/null 2>&1")
      return if installed
      message = <<~EOL
        ERROR: az is not installed. Please install the az command and configure it.
        AzureInfo uses it to detect azure resource group, location, subscription id, and tenant id.

        You can also configure these environment variables instead of installing the az cli.

            ARM_CLIENT_ID
            ARM_CLIENT_SECRET
            ARM_SUBSCRIPTION_ID
            ARM_TENANT_ID

      EOL
      if ENV['AZ_INFO_RAISE_ERROR']
        raise Error.new(message)
      else
        puts message
        exit 1
      end
    end
  end
end
