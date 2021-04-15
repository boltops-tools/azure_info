# AzureInfo

[![Gem Version](https://badge.fury.io/rb/azure_info.svg)](https://badge.fury.io/rb/azure_info)

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

Simple library to get current Azure info like subscription_id, tenant_id, group, and location.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'azure_info'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install azure_info

## Usage

```ruby
AzureInfo.group
AzureInfo.location
AzureInfo.subscription_id
AzureInfo.tenant_id
```

## Dependencies

This tool calls out to the az CLI. So the az CLI is required.

## Precedence

This library will return values using different sources with this precedence:

1. Environment variables: ARM_GROUP, ARM_LOCATION, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID
2. az cli: Usually configured in the `~/.azure/config`. Use `az configure --list-defaults` to double check.
3. Defaults: A default is set for `location=eastus`. The other values must be configured.

The config file used by the `az` command looks something like this:

~/.azure/config

    [cloud]
    name = AzureCloud

    [defaults]
    location = eastus

## Setting the Defaults with az cli

    az login --username EMAIL_ADDRESS -t TENANT_ID
    az account set --subscription SUBSCRIPTION_ID
    az configure --defaults location=eastus group=RESOURCE_GROUP

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boltops-tools/azure_info.
