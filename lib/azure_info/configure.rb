# https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration?view=azure-cli-latest
#
#     az configure --defaults location=westus2 group=MyResourceGroup
#
module AzureInfo
  class Configure < Base
    def get(name)
      item = az_configure_defaults.find do |i|
        i["name"] == name
      end
      item["value"] if item
    end

    # looks like az configure stores settings in  ~/.azure/config
    def az_configure_defaults
      return @az_configure_defaults if @az_configure_defaults
      check_az_installed!
      out = `az configure --list-defaults --output json`.strip
      @az_configure_defaults = JSON.load(out)
    end
  end
end
