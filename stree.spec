product stree
    id "Simple SGI tree"
    image sw
        id "Software"
        version 3
        order 9999
        subsys base default
            id "Base Software"
            replaces self
            exp stree.sw.base
        endsubsys
    endimage
    image man
        id "Man Pages"
        version 3
        order 9999
        subsys manpages default
            id "Man Pages"
            replaces self
            exp stree.man.manpages
        endsubsys
    endimage
endproduct
