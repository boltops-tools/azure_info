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

## Setting the Defaults with az

    az login --username EMAIL_ADDRESS -t TENANT_ID
    az account set --subscription SUBSCRIPTION_ID

    az configure --defaults location=eastus group=RESOURCE_GROUP

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/boltops-tools/azure_info.
