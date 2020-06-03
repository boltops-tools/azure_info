module AzureInfo
  class Account < Base
    def get(name)
      az_account_show[name]
    end

    # looks like az configure stores settings in  ~/.azure/config
    def az_account_show
      return @az_account_show if @az_account_show
      check_az_installed!
      out = `az account show --output json`.strip
      @az_account_show = JSON.load(out)
    end
  end
end
