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

Creates a ``smb.conf`` based on pillar data.

Configuration
=============

Installing the samba package will include a default ``smb.conf``. If you wish to override that config file, use the ``samba.config`` state, which creates a new ``smb.conf`` file based on pillar data.

The pillar data in ``pillar.example`` results in the creation of a ``smb.conf`` similar to the packaged ``smb.conf``.

