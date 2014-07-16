#template

#default[:netapp][:url] = "http://root:secret@pfiler01.example.com/vfiler01"

#### or

# default[:netapp][:https] = true
# default[:netapp][:user] = 'root'
# default[:netapp][:password] = 'secret'
# default[:netapp][:fqdn] = 'pfiler01.example.com'
# default[:netapp][:virtual_filer] = 'vfiler01'