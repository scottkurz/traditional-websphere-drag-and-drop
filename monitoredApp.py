print AdminConfig.modify('(cells/DefaultCell01|cell.xml#MonitoredDirectoryDeployment_1)', '[[enabled "true"] [monitoredDirectory "${USER_INSTALL_ROOT}/monitoredDeployableApps"] [pollingInterval "5"]]')

print AdminConfig.save()

print "Enabled monitored app deployment"



