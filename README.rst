samba
=====
Install and configure a samba server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:
    
``samba``
---------

Installs the samba server package and service.

``samba.client``
----------------

Installs the samba client package.

``samba.config``
----------------

Includes the ``samba`` state.

Creates a ``smb.conf`` based on defaults. Pillars if defined override default values.

``samba.users``
----------------

Includes the ``samba`` state.

Creates samba users (via ``smbpasswd``)  based on pillar data.

``samba.winbind``
----------------

Includes the ``samba`` state.

Installs samba-winbind packages and updates NSS (nsswitch.conf).

``samba.winbind-ad``
----------------

Includes the ``winbind`` state.

By default this state provides full Active Directory domain membership when ``samba.role`` pillar equals ``ROLE_DOMAIN_MEMBER``.

Configuration
=============
The distro supplied samba package includes a default ``smb.conf`` which is overridden by ``samba.config`` state. This formula has good defaults for samba ROLE_STANDALONE and ROLE_DOMAIN_MEMBER roles, but can be extended/overridden in pillars.
