module AzureInfo
  class Account < Base
    def get(name)
      az_account_show[name]
    end

    # looks like az configure stores settings in  ~/.azure/config
    def az_account_show
      return @az_account_show if @az_account_show

      if az_installed?
        command = "az account show --output json"
        out = `#{command}`.strip

        raise_status_error(command) unless $?.success?
        raise_empty_error(command) if out.strip == ""

        @az_account_show = JSON.load(out)
      else
        if env_vars_set?
          {}
        else
          error_message
        end
      end
    end

    def raise_status_error(command)
      message =<<~EOL
        ERROR: error running '#{command}'.
        Maybe you havent ran `az login` or configured ~/.azure manually.
        You can configure az login non-interactively with

            az login --service-principal --username USERNAME --password PASSWORD --tenant TENANT

        Per https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest#sign-in-using-a-service-principal
      EOL
      error_message(message)
    end

    def raise_empty_error(command)
      message =<<~EOL
        The '#{command}' return a blank string.
        Something went wrong. Try running it manually and confirm it returns json.
      EOL
      error_message(message)
    end
  end
end
