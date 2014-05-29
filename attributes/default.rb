default[:nginx][:dir]        = "/etc/nginx"
default[:nginx][:user]       = "www-data"
default[:nginx][:worker_connections] = 1024
default[:nginx][:worker_processes]   = 1
default[:nginx][:gzip] = "off"
default[:nginx][:disable_access_log] = true

# The following are new attributes defined in this cookbook.
default[:nginx][:listen]        = "80"
default[:nginx][:server_name]   = "mysite.com"
default[:nginx][:ssldir]        = "ssl" # inside [:nginx][:dir]
default[:nginx][:ssl_protocols] = "SSLv3 TLSv1" # PCI compliant
default[:nginx][:ssl_ciphers]   = "ALL:!aNULL:!ADH:!eNULL:!LOW:!MEDIUM:!EXP:RC4+RSA:+HIGH"
default[:nginx][:ssl_prefer_server_ciphers] = 'on'

default[:nginx][:use_epoll]     = true
default[:nginx][:multi_accept]  = true 
default[:nginx][:ssl_only]      = true # redirect all traffic from port 80 -> 443
default[:nginx][:cert_items]    = nil

# Config for upstream
default[:nginx][:upstream][:host] = "127.0.0.1"
default[:nginx][:upstream][:port] = "8000"
