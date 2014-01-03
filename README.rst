samba
=====
Install and configure a samba server.

Configuration
-------------
Installing the samba package will include a default ``smb.conf``. If you wish to override that config file, use the ``samba.config`` state, which creates a new ``smb.conf`` file based on pillar data.

The pillar data in ``pillar.example`` results in the creation of a ``smb.conf`` similar to the packaged ``smb.conf``.

States
------
``samba``
    Installs the ``samba`` package and service.
``samba.client``
    Installs the ``samba`` client package.
``samba.config``
    Installs the ``samba`` package and service, and also creates a ``smb.conf`` based on pillar data.
