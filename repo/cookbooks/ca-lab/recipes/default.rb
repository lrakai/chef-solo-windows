include_recipe 'iis' # default iis recipe installs IIS

site_name = "ca-lab"

# first, the physical path for the site files must exist
directory "#{node['iis']['docroot']}\\#{site_name}" do
    action :create
end

# second, add the index page cookbook file
cookbook_file "#{node['iis']['docroot']}\\#{site_name}\\index.html" do
    source "index.html"
end

# third, add and start the site
# binding to http port 8080
iis_site "#{site_name} site" do
    bindings "http/*:8080:"
    path "#{node['iis']['docroot']}\\#{site_name}"
    action [:add,:start]
end