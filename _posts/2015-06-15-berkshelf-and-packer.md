---
title: Adding Berkshelf feature to Packer
layout: post
primary_img: /img/post/packer-logo.png
categories: [packer, chef, berkshelf]
meta-description: Adding Berkshelf feature to Packer
---

In order to use Chef ([the Berkshelf Way](https://www.youtube.com/watch?v=hYt0E84kYUI)) with Packer, it is a common approach to define a script that wraps the invocation of Packer and runs the `berks install` (or `berks vendor`) command that resolves the Chef cookbooks that you need; an interesting discussion can be found on [Packer issue #590](https://github.com/mitchellh/packer/issues/590)

I ended up writing [our "own" Packer wrapper script](https://github.com/Alfresco/packer-common), though it is hard to debug, error-prone and "hacky"; that's why I wanted to try enhancing Packer chef-solo provisioner; I added a `pre_local_commands` parameter to the `chef-solo` Packer provisioner, allowing to run commands and resolve cookbooks (and/or databags):

```
"provisioners": [
  {
    "type": "chef-solo",
    "cookbook_paths": [
      "/tmp/berks-vendor"
    ],
    "data_bags_path": "/tmp/databags/data_bags",
    "pre_local_commands" : [
      "/bin/rm -rf /tmp/alfresco-databags",
      "/usr/bin/git clone git@github.com:maoo/data_bags_test.git /tmp/databags",
      "/bin/rm -rf /tmp/berks-vendor",
      "/opt/chefdk/bin/berks vendor /tmp/berks-vendor"
    ],
    "run_list": ["nginx::default"]
  }
```
https://github.com/mitchellh/packer/compare/master...maoo:chef-solo-precommands

To test it, you can
- checkout and build https://github.com/maoo/packer , branch `chef-solo-precommands` (follow the README)
- checkout https://github.com/maoo/packer_pre_command_test
- `packer build packer.json`

If you have the same issue, you may want to test this solution and share your thoughts.
