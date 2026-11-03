# Mein Frickel Overlay

Just some random ebuilds to keep my systems "_clean_" from random build and install flows.

## Installing the Overlay

With `app-eselect/eselect-repository`:

```
emerge -av app-eselect/eselect-repository
eselect repository add frickel-overlay git https://github.com/abusse/frickel-overlay.git
emerge --sync frickel-overlay
```

Or write `/etc/portage/repos.conf/frickel-overlay.conf` by hand:

```
[frickel-overlay]
location = /var/db/repos/frickel-overlay
sync-type = git
sync-uri = https://github.com/abusse/frickel-overlay.git
auto-sync = yes
```

If you use [eix](https://wiki.gentoo.org/wiki/Eix) you may need to execute:

```
eix-update
```

## Using packages

```
emerge -av app-misc/uni-meter
```

Ebuilds from this overlay take precedence over `::gentoo` only by
version; pin a package to the overlay explicitly if needed, e.g.
`emerge -av media-gfx/dpic::frickel-overlay`.

## Layout

One commit per package in the history; `metadata/layout.conf` sets
`masters = gentoo`, manifests are full (`ebuild <file> manifest` after
editing).
