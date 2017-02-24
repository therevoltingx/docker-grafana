require 'socket'
require 'yaml'
require 'json'
require 'mustache'

ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
