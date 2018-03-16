# Linux Management Scripts for Luna Multi Player Server 
The **Linux Management scripts** aim to provide a full management tool set for multiple **Luna Multi Player Server**. They allow to simply manage most aspects of the server

  * Installing/updating LMPServer mod
  * Creating/editing/deleting/updating server instances (including editing the Settings.xml file through a commandline interface)
  * List all instances with basic information or show detailed information on a single instance
  * Starting/stopping instances including graceful shutdown if the server has not hung up
  * Backup of game data files (instance configurations, logs, universe...)

This wiki will guide you through the setup and usage of the tool set.  
[wiki](https://github.com/artnod78/KSP-DMP-Manager/wiki)

More information for **Luna Multiplayer** [here](http://lunamultiplayer.com/)

-------------

### TODO List
* Fix for LMPServer v 0.3.28
  * ``lmm.sh updateinstance``: rename Settings file, copy new ModControl file, don't copy LiteDB.xml
  * ``lmm.sh instances`` change Settings file path (.txt to .xml)
* Hide internal functions from bash_completion
* Editing the LMPModControl.xml file through a commandline interface
* Export backups in Cloud

-------------

### PATCH Note
#### v0.0.3 (2018/03/16)
* Fix deamon. Migrate to SysD instead of SysV
* Update instances with ``lmm.sh updateinstance <instanceName>`` command
* Add instances version in ``lmm.sh instances list`` output
* Implement ``Password`` and ``WarpMaster`` settings. Can be empty
* More settings groups

#### v0.0.2 (2018/03/14)
* Fix ``checkGamePortUsed`` in ``lmm.sh instances edit <InstanceName>``
* Edit Wiki

#### v0.0.1 (2018/02/25)
* Start project
