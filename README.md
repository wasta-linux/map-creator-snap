# map-creator-unofficial snap package

- Makes use of wine and wine runtime snaps to minimize this snap's size and reduce the maintenance burden.
- Downloads MapCreatorSetup-x64-2.3.2.exe installer from FMOsoft, unless already present in ~/Downloads.

### Dependencies

These are all the snap dependencies that might need to be downloaded. If other snap
packages on your system already use some of them, then they won't need to be
downloaded again for Map Creator.

#### snap packages [~1.5 GB if none are already installed]:

- map-creator-unofficial [< 1MB]
  - snapd [50+ MB]
  - core20 [60+ MB]
  - gnome-3-38-2004 [350+ MB]
    - gtk-common-themes [90+ MB]
  - wine-platform-7-stable-core20 [400+ MB]
  - wine-platform-runtime [500+ MB]

#### winetricks installs [18 MB]

- corefonts (11 total) [4 MB]
- vcrun2013 [14 MB]

#### Map Creator installer [332 MB]

- Filename: MapCreatorSetup-x64-2.3.2.exe
- Snap installer will use ~/Downloads/MapCreatorSetup-x64-2.3.2.exe if it exists, otherwise it
  will download it from here: https://s3.amazonaws.com/fmosoft/MapCreatorSetup-x64-2.3.2.exe
