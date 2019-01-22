# Linux Management Scripts for Luna Multi Player Server 
The **Linux Management scripts** aim to provide a full management tool set for multiple **Luna Multi Player Server**. They allow to simply manage most aspects of the server

  * Installing/updating LMPServer mod
  * Creating/editing/deleting/updating server instances (editing xml files through a commandline interface)
  * List all instances with basic information or show detailed information on a single instance
  * Starting/stopping instances including graceful shutdown if the server has not hung up
  * Backup of game data files (instance configurations, logs, universe...)
  * Start/stop instances on host boot/shutdown

This wiki will guide you through the setup and usage of the tool set.  
[wiki](https://github.com/artnod78/KSP-LMP-Manager/wiki)

More information of **Luna Multi Player** [here](http://lunamultiplayer.com/)  
 

-------------

### TODO List
* Hide internal functions from bash_completion
* Editing the LMPModControl.xml file through a commandline interface
* Export backups in Cloud
* Edit Wiki

-------------

### PATCH Note
#### v0.0.6 (2019/01/22)
* Fix for LMPServer v 0.20.2
  * Include all settings files in ``instance edit`` command

#### v0.0.5 (2019/01/21)
* Fix bootstrap scripts

#### v0.0.4 (2018/03/16)
* Fix for LMPServer v 0.3.28
  * ``lmm.sh updateinstance``: rename Settings file, copy new ModControl file, don't copy LiteDB.xml
  * ``lmm.sh instances`` change Settings file path (.txt to .xml)
  * Edit Wiki

#### v0.0.3 (2018/03/16)
* Fix deamon. Migrate to SysD instead of SysV
* Update instances with new command ``lmm.sh updateinstance <instanceName>``
* Add instances version in ``lmm.sh instances list`` output
* Implement ``Password`` and ``WarpMaster`` settings. Can be empty
* More settings groups

#### v0.0.2 (2018/03/14)
* Fix ``checkGamePortUsed`` in ``lmm.sh instances edit <InstanceName>``
* Edit Wiki

#### v0.0.1 (2018/02/25)
* Start project
