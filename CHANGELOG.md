proftpd-ii CHANGELOG
====================

This file is used to list changes made in each version of the proftpd-ii cookbook.

0.5.3
-----
- Added SFTPAuthorizedUserKeys directive

0.5.2
-----
- Added TLSCertificateChainFile directive

0.5.1
-----
- Global section with all default server directives (#4)
- Development: support for centos7 with docker on vagrant
- Added CreateHome directive
- sFTP package/example is optional since it's a custom package
- Attribute explanations on `attributes/default.rb`

0.5.0
-----
- Added support for sFTP module and configuration

0.4.0
-----
- Added support for TLS configuration

0.3.0
-----
- Added support for LDAP module and configuration

0.2.0
-----
- Support for LWRPs

0.1.0
-----
- Initial release of proftpd-ii
