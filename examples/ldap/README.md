# Login
Login DN: cn=admin,dc=acme,dc=local
Password: changeit

# ou.ldif
dn: ou=Users,dc=acme,dc=local
objectClass: organizationalUnit
objectClass: top
ou: Users

dn: ou=Groups,dc=acme,dc=local
objectClass: organizationalUnit
ou: Groups

# groups.ldif
dn: cn=Acme Superusers,ou=Groups,dc=acme,dc=local
objectClass: posixGroup
cn: Acme Superusers
gidNumber: 5000
memberUid: superuser

dn: cn=Acme Servicers,ou=Groups,dc=acme,dc=local
objectclass: posixGroup
cn: Acme Servicers
gidnumber: 5001
memberUid: service

dn: cn=Acme Managers,ou=Groups,dc=acme,dc=local
objectClass: posixGroup
cn: Acme Managers
gidNumber: 5002
memberUid: manager

dn: cn=Acme Users,ou=Groups,dc=acme,dc=local
objectClass: posixGroup
cn: Acme Users
gidNumber: 5003
memberUid: user

# users.ldif
dn: cn=user,ou=Users,dc=acme,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: user
sn: Lastname
givenName: Firstname
cn: Acme User
displayName: Acme User
uidNumber: 10003
gidNumber: 8000
userPassword: changeit
homeDirectory: /home/user
mail: user@acme.local

dn: cn=manager,ou=Users,dc=acme,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: manager
sn: Lastname
givenName: Firstname
cn: Acme Manager
displayName: Acme Manager
uidNumber: 10002
gidNumber: 8000
userPassword: changeit
homeDirectory: /home/manager
mail: manager@acme.local

dn: cn=service,ou=Users,dc=acme,dc=local
cn: service
displayName: Acme Service
gidnumber: 8000
givenName: Firstname
homedirectory: /home/service
loginshell: /bin/bash
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: simpleSecurityObject
sn: Lastname
uid: service
uidnumber: 10001
userPassword: changeit
mail: service@acme.local

dn: cn=superuser,ou=Users,dc=acme,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectclass: simpleSecurityObject
uid: superuser
sn: Lastname
givenName: Firstname
cn: Acme Superuser
displayName: Acme Superuser
uidNumber: 10000
gidNumber: 8000
userPassword: changeit
homeDirectory: /home/superuser
mail: superuser@acme.local