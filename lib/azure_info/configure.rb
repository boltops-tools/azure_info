# https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration?view=azure-cli-latest
#
#     az configure --defaults location=westus2 group=MyResourceGroup
#
module AzureInfo
  class Configure < Base
    def get(name)
      item = az_configure.find do |i|
        i["name"] == name
      end
      item["value"] if item
    end

  private
    # looks like az configure stores settings in  ~/.azure/config
    def az_configure
      if az_installed?
        return @az_configure if @az_configure
        out = `az configure --list-defaults --output json`.strip
        @az_configure = JSON.load(out)
      else
        if env_vars_set?
          []
        else
          error_message
        end
      end
    end
  end
end
