# Example build of C99 on Irix

This is a trivial C99 application. The meat of this project is the
Makefile and packaging setup. 

# Build Dependencies

- GNU Make (I used 4.2, but 3.81 should probably work too)
- MipsPro C99 (I used 7.4.4m, but this should compile on any C99
- Irix 6.5.22 (this is what I developed on. I am not sure what the
  packaging differences are for earlier Irix)
- GNU Groff (I used the ancient one included in the SGI Freeware CDs)

You may need to edit the Makefile to define where the various tools are.

# Discussion

## Makefile

See `Makefile` for more disscussion.

## Irix packaging

The stree.spec file is the "metadata" for the package and the 
stree.idb file lists which files need to be packaged from the 
build, where they will go in the final system and ownerships
and permissions.

The spec file builds two subsystems of the main package, the
documentation and the binary part. Both are set to be default
installs and none of the files are marked for rqsall(1).

Important note: you will need to increment both `version` numbers
in the spec file if you build a new version and want to inst(1M)
it _over_ an existing install. These version values have nothing
to do with the VERSION in the Makefile (the human readable 
version), rather they are used internally by the system to decide
when to update a package. It will need to incremented by one 
every time you go through the cycle of package build then inst(1M).

On Irix itself, you can use swpkg(1M) to open both files and 
use a GUI to modify parameters. Otherwise the formats are
described in gendist(1M).

After you have built the tardist you can install with inst(1M)
or Software Manager. For inst(1M)

```
su -
inst -a -f stree-1.0.0.tardist
```

## C99 code

The code itself is a trivial application that builds a recursive,
indented list of all files under the current working directory.
