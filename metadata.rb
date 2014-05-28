description       "nginx as an ssl terminator and reverse proxy"
version           "0.1.12"

%w{ ubuntu debian centos redhat fedora }.each do |os|
  supports os
end

depends "nginx"
