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

Installs samba-winbind packages and updates NSS (nsswitch.conf). Run this state after joining the Domain.

``samba.winbind-ad``
----------------

Includes the ``winbind`` state.

By default this state provides full Active Directory (AD) domain membership if ``samba.role`` equals ``ROLE_DOMAIN_MEMBER``.

``samba.clean``
--------------

Calls `clean` state for all modules to completely remove samba and winbind.

Configuration
=============
The distro samba package includes a default ``smb.conf`` which is overridden by ``samba.config`` state. This formula has good defaults for samba ROLE_STANDALONE and ROLE_DOMAIN_MEMBER roles, but can be extended/overridden in pillars.


AD integration
==================

Ensure host's assigned (dhcp) ipaddress is reflecting DNS.

.. code-block:: bash

     [myhost]$ ip addr
     [myhost]$ host myhost.example.com

Ensure system time is NTP synchronized (yes)!!

.. code-block:: bash

     $ # timedatectl
               Local time: Fri 2018-02-09 08:34:10 MST
           Universal time: Fri 2018-02-09 15:34:10 UTC
                 RTC time: Fri 2018-02-09 15:34:21
                Time zone: America/Denver (MST, -0700)
          Network time on: yes
         NTP synchronized: yes
          RTC in local TZ: no

Join the domain in three commands-

.. code-block:: bash

     $ sudo net ads join EXAMPLE.COM -U 'domainAdminUser'
     Enter domainAdminUser password:
     Using short domain name -- EXAMPLE
     Joined MYHOST to dns domain ‘example.com'

     $ sudo kinit -k MYHOST\$@EXAMPLE.COM

     $ sudo systemctl restart winbind

If 'kinit' fails then try rebooting and checking for issues with time and dns.

