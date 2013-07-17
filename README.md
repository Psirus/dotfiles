Christoph's Dot Files
======================

This my collection of config files, used to set up my system to my liking and
increase my productivity (if only). Additionally, I can reference to it if someone asks, and someday I'll be able to track the *progress* of these things.

I will continue to pick & choose bits from all over the internet whenever I
come across something I think is interesting. I'll try to attribute the source,
but for some of the stuff I have already accumulated I simply forgot, *sorry*.

Installation:
-------------
Should be relatively painless::

    git clone git://github.com/psirus/dotfiles.git ~/.dotfiles
    cp .dotfiles/post-commit .dotfiles/.git/hooks/

The post-commit hook will link all the hidden dotfiles in this directory from
your home directory.

Features:
---------
Almost *stock* xmonad experience, but with integration for Xfce. Also,
I've defined keybindings for gmusicbrowser.

Feedback:
---------
Tell me what you think or whether you have any problems with my configs:
`Issues <https://github.com/Psirus/dotfiles/issues>`_

Thanks to:
----------

John Piasetzki for `the post-commit idea <https://github.com/jpiasetz/dotfiles>`_
