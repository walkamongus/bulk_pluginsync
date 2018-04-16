#### Table of Contents

* [Description](#description)
* [Usage](#usage)
  * [bulk\_pluginsync::compile\_master\_pool\_address](#bulk_pluginsynccompile_master_pool_address)
  * [Where to apply this module](#where-to-apply-this-module)
  * [Changing your agent provisioning script](#changing-your-agent-provisioning-script)
* [Limitations](#limitations)

## Description

This module aims to decrease the amount of time a puppet agent needs to spend syncing plugins from the puppet master.

Specifically, the module places a tar.gz of all of the plugins that are already synced on the master into /packages which is already hosted for agents to pull the frictionless agent installer from in PE.  The module also lays down a small script that can be downloaded and run on the agent side to extract the tarball into the directory for agent plugins.  

## Usage

### bulk_pluginsync::compile_master_pool_address

You can configure where agents will download the pluginsync tarball from with this parameter.

By default, it will be the primary master ( the master with the CA running on it).

### Where to apply this module

You should classify this module on all of your master nodes.  

### Changing your agent provisioning script

Add the following before you install the puppet agent in your script.

```
curl -k https://<master_host_name>:8140/packages/current/bulk_pluginsync.bash | sudo bash
```

## Limitations

Should work on all PE master platforms.
