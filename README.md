# Mein Frickel Overlay

Just some random ebuilds to keep my systems "_clean_" from random build and install flows.

## Installing the Overlay

In order to [manage overlays](https://wiki.gentoo.org/wiki/Overlay), the
package [**app-portage/layman**](https://wiki.gentoo.org/wiki/Layman) must be
installed into your Gentoo environment:

```
emerge -av app-portage/layman
```

If the installation of _layman_ was successfully completed, then you are ready
to sync the content of this repository:

```
layman -o https://raw.githubusercontent.com/abusse/frickel-overlay/master/master/repositories.xml -f -a frickel-overlay
```

If you use [eix](https://wiki.gentoo.org/wiki/Eix) you may need to execute:

```
eix-update
```
