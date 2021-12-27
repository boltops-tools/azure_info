# https://docs.microsoft.com/en-us/cli/azure/azure-cli-configuration?view=azure-cli-latest
#
#     az configure --defaults location=westus2 group=MyResourceGroup
#
module AzureInfo
  class Configure
    def get(name)
      item = azure_configs.find do |i|
        i["name"] == name
      end
      item["value"] if item
    end

  private
    # looks like az configure stores settings in  ~/.azure/config
    def azure_configs
      if az_installed?
        return @azure_configs if @azure_configs
        out = `az configure --list-defaults --output json`.strip
        @azure_configs = JSON.load(out)
      else
        if env_vars_set?
          []
        else
          error_message
        end
      end
    end

    def az_installed?
      system("type az > /dev/null 2>&1")
    end

    def env_vars
      %w[
        ARM_CLIENT_ID
        ARM_CLIENT_SECRET
        ARM_LOCATION
        ARM_SUBSCRIPTION_ID
        ARM_TENANT_ID
      ]
    end

    def env_vars_set?
      env_vars.all? { |var| ENV[var] }
    end

    def error_message
      all_vars = format_list(env_vars)
      unset_vars = format_list(env_vars.reject { |var| ENV[var] })
      message = <<~EOL
        ERROR: az is not installed. Please install the az command and configure it.
        AzureInfo uses it to detect azure resource group, location, subscription id, and tenant id.

        You can also configure these environment variables instead of installing the az cli.

        #{all_vars}

        Currently, the unset vars are:

        #{unset_vars}

      EOL
      if ENV['AZ_INFO_RAISE_ERROR']
        raise Error.new(message)
      else
        puts message
        exit 1
      end
    end

    def format_list(vars)
      vars.map { |var| "    #{var}" }.join("\n")
    end
  end
end
