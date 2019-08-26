
include:
  - samba.winbind-ad.clean      ##because it depends on samba service
  - samba.winbind.clean         ##because it depends on samba service
  - samba.users.clean           ##because it depends on samba service
  - samba.client.clean
  - samba.config.clean
  - samba.server.clean
