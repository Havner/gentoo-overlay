# DISCLAIMER

ebuilds in this overlay are made with the least effort possible (not really, but
some might, so safer to treat them that way). I don't aim for them to be
production ready. I just need those packages to integrate with the system so I
can uninstall them when no longer needed.

Most of the times there are no usable use flags, the dependencies are likely
wrong/incomplete and those ebuilds probably don't follow the rules
properly. This is simply my own private playground, not an overlay to be used by
others. You have been warned.

This overlay needs to be coupled with [GURU] for some dependencies.

# Highlights

This overlay contains latest [hyprland] with most of its dependencies. If some
hypr package from [upstream] is not here it means its newest version is already
included in the main gentoo repository (something older like scanner or
qt-support) or in [GURU] (hypridle, hyprlock, hyprpaper, etc). Everything else
is in here in the latest versions. I'll try to keep it up to date, at least as
long as I use hyprland.

Also included is [hyprpanel] with all its dependencies (astal,
aylurs-gtk-shell, swww, etc) that according to what I've been able to find is
not available anywhere else for gentoo (at least not in its newest
versions). Some other runtime dependencies are in GURU so make sure you've got
that enabled as well.

<br>
<br>

![screenshot]

<!----------------------------------------------------------------------------->

[hyprland]: https://hypr.land/
[upstream]: https://github.com/hyprwm
[GURU]: https://wiki.gentoo.org/wiki/Project:GURU
[hyprpanel]: https://hyprpanel.com/

[screenshot]: https://i.ibb.co/5hrpyYJ4/hypr.jpg
