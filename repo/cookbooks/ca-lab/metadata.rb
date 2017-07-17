name 'ca-lab' # Name of your cookbook
chef_version '>= 12.7' # Minimum Chef version
depends 'chocolatey', '~> 1.2.0'  # ca-lab depends on chocolatey cookbook
depends 'iis', '~> 6.7.2'