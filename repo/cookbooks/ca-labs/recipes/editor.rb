windows_package 'notepad++' do
    source 'https://notepad-plus-plus.org/repository/7.x/7.4.2/npp.7.4.2.Installer.x64.exe'
    guard_interpreter :powershell_script
    not_if "Test-Path 'C:\\Program Files\\Notepad++\\notepad++.exe'"
 end