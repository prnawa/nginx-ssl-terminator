include_recipe "nginx::default"

defaults_ssl_listen = { "ssl_listen" => "443" }

cert_key_pairs = node[:nginx][:cert_items].map do |cert_item|
  
  # By merging the cert data into the default_ssl_listen data,
  # we guarantee an ssl_listen value of '443' if not specified
  # in the cert data.
  cert      = defaults_ssl_listen.merge(node[:nginx][:sslcertkey][cert_item])
  paths     = {
    "crt_path"  => File.join(node[:nginx][:dir], node[:nginx][:ssldir], "#{cert["id"]}.crt"),
    "key_path"  => File.join(node[:nginx][:dir], node[:nginx][:ssldir], "#{cert["id"]}.key"),
  }
  
  # cert is merged into paths in the event that paths were specified
  # in the cert hash.
  paths.merge(cert)
end

# Create directory for Certs
directory "#{node[:nginx][:dir]}/#{node[:nginx][:ssldir]}" do
  mode 0755
  owner node[:nginx][:user]
  action :create
  recursive true
end

cert_key_pairs.each do |ckp|
  
  # Write the .crt file, eg: /etc/nginx/ssl/foo.crt
  template ckp["crt_path"] do
    source "ssl.erb"
    owner  "root"
    group  "root"
    mode   0600
    variables(:content => ckp["cert"].join("\n"))
  end 

  # Write the .key file, eg: /etc/nginx/ssl/foo.key
  template ckp["key_path"] do
    source "ssl.erb"
    owner  "root"
    group  "root"
    mode   0600
    variables(:content => ckp["key"].join("\n"))
  end 
end

# Write the new nginx config file
template "#{node[:nginx][:dir]}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(
    :ssl_server_declarations => cert_key_pairs.map { |ckp| ckp.reject { |k, v| ["crt", "key"].include?(k) } }
  )
  notifies :reload, "service[nginx]"
end
