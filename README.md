# Luna Multiplayer - Linux Server Management Scripts
The **Linux Server Management scripts** aim to provide a full management tool set for a **Luna Multiplayer server**. They allow to manage most aspects of the server

  * Installing and updating mod
  * Creating/editing/deleting server instances (including editing the serverconfig through a commandline interface)
  * List all instances with basic information or show detailed information on a single instance
  * Starting/stopping instances including graceful shutdown if the server has not hung up
  * Backup of game data files (instance configurations, logs, saves)

This wiki will guide you through the setup and usage of the tool set.  
[wiki](https://github.com/artnod78/KSP-DMP-Manager/wiki)

More information for **Luna Multiplayer** [here](http://lunamultiplayer.com/)

-------------

### TODO List
* ~~Update instances with ``lmm.sh updateinstance <instanceName>`` command~~
* ~~More settings groups~~
* ~~Implement ``Password`` and ``WarpMaster`` settings. Can be empty~~
* ~~Add instances version in ``lmm.sh instances list`` output~~
* Hide internal functions from bash_completion
* ~~Fix deamon. Migrate to SysD instead of SysV~~
* Export backups in Cloud
* ~~Compatible LMP 0.3.28~~

-------------

### PATCH Note
#### 2018/03/14 v0.0.2
* Fix ``checkGamePortUsed`` in ``lmm.sh instances edit <InstanceName>``
* Edit Wiki
#### 2018/02/25 v0.0.1
* Start project
