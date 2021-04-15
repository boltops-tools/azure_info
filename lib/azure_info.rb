require "azure_info/version"
require "json"

module AzureInfo
  autoload :Account,   "azure_info/account"
  autoload :Base,      "azure_info/base"
  autoload :Configure, "azure_info/configure"
  class Error < StandardError; end

  def group
    ENV['ARM_GROUP'] || configure.get("group")
  end
  alias_method :group_id, :group

  def location
    ENV['ARM_LOCATION'] || configure.get("location") || "eastus"
  end

  def subscription_id
    ENV['ARM_SUBSCRIPTION_ID'] || account.get("id")
  end
  alias_method :subscription, :subscription_id

  def tenant_id
    ENV['ARM_TENANT_ID'] || account.get("tenantId")
  end
  alias_method :tenant, :tenant_id

private
  def configure
    @configure ||= Configure.new
  end

  def account
    @account ||= Account.new
  end

  extend self
end
