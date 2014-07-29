# spec/support/matchers.rb

# def my_custom_matcher(resource_name)
#   ChefSpec::Matchers::ResourceMatcher.new(:netapp_svm, :create, resource_name)
# end

if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method :netapp_svm

  def create_netapp_aggregate(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_aggregate', :create, resource_name)
  end

  def delete_netapp_aggregate(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_aggregate', :delete, resource_name)
  end

  def enable_netapp_feature(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_feature', :enable, resource_name)
  end

  def create_netapp_group(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_group', :create, resource_name)
  end

  def delete_netapp_group(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_group', :delete, resource_name)
  end

  def create_netapp_iscsi(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_iscsi', :create, resource_name)
  end

  def delete_netapp_iscsi(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_iscsi', :delete, resource_name)
  end

  def create_netapp_lif(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_lif', :create, resource_name)
  end

  def delete_netapp_lif(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_lif', :delete, resource_name)
  end

  def create_netapp_nfs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_nfs', :create, resource_name)
  end

  def delete_netapp_nfs(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_nfs', :delete, resource_name)
  end

  def create_netapp_qtree(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_qtree', :create, resource_name)
  end

  def delete_netapp_qtree(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_qtree', :delete, resource_name)
  end

  def create_netapp_role(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_role', :create, resource_name)
  end

  def delete_netapp_role(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_role', :delete, resource_name)
  end

  def create_netapp_svm(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_svm', :create, resource_name)
  end

  def delete_netapp_svm(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_svm', :delete, resource_name)
  end

  def create_netapp_user(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_user', :create, resource_name)
  end

  def delete_netapp_user(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_user', :delete, resource_name)
  end

  def create_netapp_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_volume', :create, resource_name)
  end

  def delete_netapp_volume(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new('netapp_volume', :delete, resource_name)
  end
end