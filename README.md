# bash-bookmarks

This file implements bash shell bookmarks, it temporarily stores your current directory under a name, lets you create an alias with that name; you can list the bookmarks you have, delete them, persist them in a "master directory" that gets loaded every time you load these functions, and so forth.

## Usage

Use is as simple as possible:

```shell
$ # Load the definitions.
$ source bookmarks.bash
$ # Go to some deeply nested directory
$ cd ~/Workspace/Team/Project/Application/Subsystem/Config/Meh
[.../Meh] $ bm meh
"meh" ==> /home/$ME/Workspace/Team/Projects/Application/Subsystem/Config/Meh
$ # Go somewhere else
$ cd ~/Documents
$ bm
Bookmarks:
 + meh [/home/$ME/Workspace/Team/Projects/Application/Subsystem/Config/Meh]
$ meh
/home/$ME/Workspace/Team/Projects/Application/Subsystem/Config/Meh
[.../Meh] $ # back where we started
```

