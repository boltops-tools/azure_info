module AzureInfo
  class Base
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
        ARM_ACCOUNT
      ]
    end

    def env_vars_set?
      env_vars.all? { |var| ENV[var] }
    end

    def error_message(message=nil)
      all_vars = format_list(env_vars)
      unset_vars = format_list(env_vars.reject { |var| ENV[var] })
      message ||= <<~EOL
        ERROR: az is not installed. Please install the az command and configure it.
        AzureInfo uses it to detect azure resource group, location, subscription id, and tenant id.

        You can also configure these environment variables instead of installing the az cli.

        #{all_vars}

        Currently, the unset vars are:

        #{unset_vars}

      EOL
      show_error(message)
    end

    def show_error(message)
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
