AdminTask.configureAdminWIMUserRegistry('[-verifyRegistry true ]')
AdminConfig.save()
secCfgId = AdminConfig.getid("/Security:/")
AdminConfig.modify(secCfgId,[['appEnabled','true']])
AdminConfig.save()
print "appSecurityEnabled = " + AdminTask.isAppSecurityEnabled()
print "globalSecurityEnabled = " + AdminTask.isGlobalSecurityEnabled()
print AdminConfig.save()
