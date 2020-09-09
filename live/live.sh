#!/bin/bash
##################################################################################################################
#
echo "                                 “Nos ensinem a ter liberdade novamente”  "
#
echo "      ##########      #######       ##      ##     #########               ############      ############"
echo "     ##              ##            ##      ##     ##       ##             ##        ##     ##"
echo "    ##              ##            ##      ##     ##      ##              ##        ##     ##"
echo "   ##              #######       ##      ##     ########      ######    ##        ##      ############"
echo "  ##              ##            ##      ##     ##      ##              ##        ##                  ##"
echo " ##              ##            ##      ##     ##      ##              ##        ##                 ##"
echo "##########      #######       ##########     #########               ############      ############"
#
##################################################################################################################
set -e

LINUX_IMAGE="linux-image-5.7.0-0.bpo.2"
LINUX_HEADERS="linux-headers-5.7.0-0.bpo.2"

lb config noauto \
     --architectures amd64 \
     --mode "debian" \
     --linux-packages "linux-image-5.7.0-0.bpo.2 linux-headers-5.7.0-0.bpo.2" \
     --bootloader "syslinux,grub-efi" \
     --system live \
     --compression gzip \
     --backports true \
     --binary-filesystem "ext4" \
     --initramfs live-boot \
     --initramfs-compression gzip \
     --loadlin fale \
     --win32-loader false \
     --iso-application ceub-os \
     --iso-volume ceub-os \
     --memtest memtest86+ \
     --binary-images iso-hybrid \
     --initsystem systemd \
     --debian-installer false \
     --debian-installer-gui false \
     --distribution buster \
     --debian-installer-distribution buster \
     --archive-areas "main contrib non-free" \
     --updates true \
     --security true \
     --mirror-chroot http://httpredir.debian.org/debian/ \
     --mirror-bootstrap http://httpredir.debian.org/debian/ \
     --mirror-binary http://httpredir.debian.org/debian/ \
     --mirror-binary-security http://security.debian.org/ \
     --bootappend-live "boot=live components timezone=America/Sao_Paulo locales=pt_BR.UTF-8 keyboard-layouts=br keyboard-variants=abnt2 hostname=EducatuX username=educatux noprompt noeject autologin splash blacklist.nouveau=1 i915.modeset=1 gfxpayload=640x480 acpi_backlight=vendor acpi_osi=!" \
     --bootappend-live-failsafe "initrd=/live/initrd boot=live persistence config memtest noapic noapm nodma nomce nolapic nomodeset nosmp splash vga=791 pti=off blacklist.nouveau=1 i915.modeset=1 gfxpayload=640x480 acpi_backlight=vendor acpi_osi=!" \
     --firmware-chroot true \
     --firmware-binary true \
     --apt-options "--force-yes --yes -oAcquire::Check-Valid-Until=false" \
     --apt apt \
     --apt-source-archives "false" \
     --apt-indices true \
     --apt-recommends false \
     --apt-secure true \
     --debconf-priority critical \
     --iso-preparer "CEUB" \
     --iso-publisher "CEUB - https://www.ceubos.com.br" \
     --keyring-packages "blueproximity wireless-regdb=2020.04.29-2~bpo10+1 qtbase5-dev \
     glx-alternative-mesa=1.2.0~bpo10+1 update-glx=1.2.0~bpo10+1 glx-diversions=1.2.0~bpo10+1 \
     python3-dev arduino arduino-mk dfu-programmer calamares-settings-educatux-hybrid \
     calamares shotcut btrfs-progs python3-btrfs extlinux openboard flatpak snapd vrms \
     iramuteq mesa-utils-extra flashplayer-mozilla firefox-esr firefox-esr-l10n-all \
     fonts-arabeyes fonts-arphic-ukai fonts-arphic-uming fonts-beng fonts-beng-extra \
     fonts-bpg-georgian fonts-cantarell fonts-dejavu fonts-dejavu-core fonts-dejavu-extra \
     fonts-deva fonts-deva-extra fonts-droid-fallback fonts-dustin fonts-dzongkha \
     fonts-farsiweb fonts-freefont-ttf fonts-gargi fonts-gujr fonts-gujr-extra fonts-guru \
     fonts-guru-extra fonts-ipafont fonts-ipafont-gothic fonts-ipafont-mincho fonts-kacst \
     fonts-kacst-one fonts-kalapi fonts-lato fonts-liberation fonts-lmodern \
     fonts-lohit-beng-assamese fonts-lohit-beng-bengali fonts-lohit-deva \
     fonts-lohit-gujr fonts-lohit-guru fonts-lohit-knda fonts-lohit-mlym \
     fonts-lohit-taml fonts-lohit-taml-classical fonts-lohit-telu fonts-lyx \
     fonts-mlym fonts-nakula fonts-nanum fonts-nanum-coding fonts-noto fonts-noto-cjk \
     fonts-noto-hinted fonts-noto-mono fonts-noto-unhinted fonts-opensymbol \
     fonts-sahadeva fonts-samyak-deva fonts-samyak-gujr fonts-samyak-mlym \
     fonts-samyak-taml fonts-sarai fonts-sil-abyssinica fonts-sil-andika \
     fonts-sipa-arundina fonts-smc fonts-taml fonts-telu fonts-telu-extra \
     fonts-tlwg-garuda fonts-tlwg-garuda-ttf fonts-tlwg-kinnari \
     fonts-tlwg-kinnari-ttf fonts-tlwg-laksaman fonts-tlwg-laksaman-ttf \
     fonts-tlwg-loma fonts-tlwg-loma-ttf fonts-tlwg-mono fonts-tlwg-mono-ttf \
     fonts-tlwg-norasi fonts-tlwg-norasi-ttf fonts-tlwg-purisa fonts-tlwg-purisa-ttf \
     fonts-tlwg-sawasdee fonts-tlwg-sawasdee-ttf fonts-tlwg-typewriter \
     fonts-tlwg-typewriter-ttf fonts-tlwg-typist fonts-tlwg-typist-ttf \
     fonts-tlwg-typo fonts-tlwg-typo-ttf fonts-tlwg-umpush fonts-tlwg-umpush-ttf \
     fonts-tlwg-waree fonts-tlwg-waree-ttf fonts-ukij-uyghur fonts-unikurdweb \
     fonts-vlgothic fonts-wqy-microhei fonts-wqy-zenhei fonts-ubuntu-title \
     cinnamon-plasma-theme arc-icons-remix arc-theme cinnamon-l10n \
     live-task-cinnamon task-cinnamon-desktop dosfstools nautilus-dropbox \
     apt-transport-https  google-talkplugin gtk2-engines-pixbuf cifs-utils \
     doxygen vim openscenegraph libopenthreads20 libopenthreads20 openscenegraph \
     openscenegraph-doc openscenegraph-examples eviacam onboard mate-themes \
     libkpmcore-dev libkpmcore7 educatux-games64 fakeroot mpg123 unrar \
     plymouth plymouth-themes plymouth-theme-hamara xserver-xorg-input-aiptek \
     xserver-xorg-input-evdev xserver-xorg-input-kbd xserver-xorg-input-multitouch \
     xserver-xorg-input-mouse xserver-xorg-video-qxl nodejs fonts-dejavu \
     fonts-dejavu-core fonts-dejavu-extra fonts-opensymbol ttf-mscorefonts-installer \
     qemu-utils qemu-block-extra gir1.2-spiceclientgtk-3.0 virt-manager ovmf \
     libvirt-sanlock libvirt-clients libvirt-daemon-system munin-libvirt-plugins \
     nbdkit-plugin-libvirt qemu-kvm ebtables dnsmasq puredata-utils puredata-gui \
     puredata-import puredata-extra pd-aubio pd-cyclone pd-deken accountsservice acl \
     alsa-firmware-loaders alsa-oss alsa-utils anacron apg aspell aspell-pt-br \
     at-spi2-core audacity audacity-data autoconf automake autopoint  avahi-daemon \
     brasero brasero-cdrkit brasero-common cdrdao dvdauthor growisofs wodim vcdimager \
     b43-fwcutter bc bdf2psf bind9-host binutils blinken blt blueman bluetooth bluez \
     bluez-cups bluez-firmware bluez-obexd bluez-tools bnd brasero-cdrkit brasero-common \
     busybox bzip2 ca-certificates ca-certificates-java caribou cdrdao cheese cheese-common \
     jupyter-notebook cjs coinor-libcbc3 coinor-libcgl1 coinor-libclp1 coinor-libcoinmp1v5 \
     coinor-libcoinutils3v5 coinor-libosi1v5 colord colord-data \
     composer console-setup console-setup-linux cpp cracklib-runtime \
     crda culmus cups cups-browsed cups-bsd cups-client cups-common \
     cups-core-drivers cups-daemon cups-filters cups-filters-core-drivers \
     cups-pk-helper cups-ppdc cups-server-common curl dbconfig-common dbus dbus-user-session dbus-x11 dconf-gsettings-backend dconf-service debhelper debootstrap \
     default-jdk default-jdk-headless default-jre default-jre-headless \
     default-mysql-client desktop-base desktop-file-utils \
     dh-autoreconf dh-strip-nondeterminism dictionaries-common \
     djvulibre-bin dkms dnsutils docbook-xml docbook-xsl dreamchess \
     dreamchess-data dvdauthor efibootmgr eog espeak-ng-data exfat-fuse \
     exfat-utils extlinux ffmpeg file file-roller finger  five-or-more \
     fontconfig fontconfig-config four-in-a-row freeglut3 fritzing \
     fritzing-data fritzing-parts fuse fxload g++ gawk gconf-service \
     gconf2 gconf2-common gcr \
     gdebi gdebi-core \
     gdisk geary \
     gedit gedit-common gedit-plugins \
     genisoimage ghostscript gist \
     git git-gui git-man gkbd-capplet \
     gnome-accessibility-themes gnome-backgrounds gnome-bluetooth gnome-calculator \
     gnome-control-center gnome-control-center-data gnome-desktop3-data \
     gnome-font-viewer gnome-keyring gnome-klotski gnome-mahjongg gnome-mime-data \
     gnome-mines gnome-nettool gnome-nibbles gnome-online-accounts gnome-orca \
     gnome-robots gnome-screenshot gnome-settings-daemon gnome-sudoku \
     gnome-sushi gnome-system-monitor gnome-taquin gnome-terminal \
     gnome-terminal-data gnome-tetravex gnome-themes-standard \
     adwaita-icon-theme gnome-user-guide gnome-user-share gnome-video-effects \
     nautilus-gtkhash nautilus-emblems nautilus-scripts-manager nautilus-share nautilus-image-converter \
     gir1.2-accountsservice-1.0 gir1.2-appindicator3-0.1 gir1.2-atk-1.0 gir1.2-atspi-2.0 \
     gir1.2-caribou-1.0 gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-cmenu-3.0 \
     gir1.2-cogl-1.0 gir1.2-coglpango-1.0 gir1.2-cvc-1.0 gir1.2-freedesktop \
     gir1.2-gdesktopenums-3.0 gir1.2-gdkpixbuf-2.0 gir1.2-git2-glib-1.0 \
     gir1.2-gkbd-3.0 gir1.2-glib-2.0 gir1.2-gnomebluetooth-1.0 gir1.2-gnomedesktop-3.0 \
     gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0 gir1.2-gtk-3.0 \
     gir1.2-gtkclutter-1.0 gir1.2-gtksource-3.0 gir1.2-gucharmap-2.90 gir1.2-ibus-1.0 \
     gir1.2-javascriptcoregtk-4.0 gir1.2-json-1.0 gir1.2-keybinder-3.0 \
     gir1.2-meta-muffin-0.0 gir1.2-nm-1.0 gir1.2-notify-0.7 gir1.2-pango-1.0 \
     gir1.2-peas-1.0 gir1.2-polkit-1.0 gir1.2-rb-3.0 gir1.2-secret-1 \
     gir1.2-soup-2.4 gir1.2-totem-1.0 gir1.2-totem-plparser-1.0 \
     gir1.2-upowerglib-1.0 gir1.2-vte-2.91 gir1.2-webkit2-4.0 \
     gir1.2-wnck-3.0 gir1.2-xapp-1.0 gir1.2-xkl-1.0 gir1.2-zeitgeist-2.0 \
     gnote gnucap gnupg2 gocr goldendict gparted gphoto2 greybird-gtk-theme grilo-plugins-0.3 \
     groff-base growisofs \
     gscan2pdf gsettings-desktop-schemas gsfonts gsfonts-x11 gstreamer1.0-alsa gstreamer1.0-clutter-3.0 gstreamer1.0-espeak gstreamer1.0-libav gstreamer1.0-nice gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-pulseaudio gstreamer1.0-x \
     gthumb gthumb-data \
     gtk-update-icon-cache gtk2-engines \
     gvfs gvfs-backends gvfs-bin gvfs-common gvfs-daemons gvfs-fuse gvfs-libs \
     grub-common grub-efi-amd64 grub-efi-amd64-bin grub-pc-bin grub2-common \
     hddtemp hfsplus hfsutils hicolor-icon-theme hitori hspell hspell-gui \
     i965-va-driver iagno imagemagick imagemagick-6-common imagemagick-6.q16 \
     initramfs-tools initramfs-tools-core intltool-debian \
     inxi iptraf iptraf-ng iputils-tracepath iso-codes iso-flags-png-320x240 \
     isolinux itop iw jackd jackd2 jsonlint \
     kde-l10n-ptbr libkf5khtml-bin kde-runtime kde-runtime-data kdelibs-bin kdelibs5-data kdelibs5-plugins kdoctools kexec-tools kio klibc-utils \
     konwert konwert-filters kpackagetool5 krb5-locales \
     lightsoff live-boot live-config live-config-systemd live-tools live-task-localisation live-task-recommended \
     locales lp-solve lsb-release lsof madfuload media-player-info melt \
     menu-l10n mesa-utils mesa-va-drivers mesa-vdpau-drivers \
     metacity metacity-common \
     mime-support minissdpd mobile-broadband-provider-info modemmanager moreutils \
     mousetweaks mtools \
     muffin muffin-common \
     myspell-pt-br \
     net-tools netpbm network-manager network-manager-gnome \
     ntfs-3g ntp ntpdate ocl-icd-libopencl1 \
     odbcinst odbcinst1debian2 \
     opencc openssh-client openssl \
     p11-kit p11-kit-modules \
     p7zip p7zip-full \
     packagekit packagekit-tools \
     patch patchutils \
     pciutils \
     perl perl-openssl-defaults perl-tk \
     phalanx \
     phonon phonon-backend-gstreamer phonon-backend-gstreamer-common phonon4qt5 phonon4qt5-backend-vlc \
     pinentry-gnome3 libfrei0r-ocaml frei0r-plugins pkg-config plasma-scriptengine-javascript \
     po-debconf policykit-1 policykit-1-gnome poppler-data poppler-utils \
     printer-driver-gutenprint proj-data psf-unifont psmisc psutils \
     pulseaudio pulseaudio-module-bluetooth pulseaudio-utils \
     puredata-utils puredata-gui puredata-import puredata-extra \
     pd-aubio pd-cyclone pd-deken \
     pxelinux qdbus qjackctl \
     qml-module-org-kde-games-core qml-module-qtgraphicaleffects qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-privatewidgets qml-module-qtquick-window2 qml-module-qtquick2 \
     qtchooser qtcore4-l10n \
     quadrapassel \
     r-base-core r-cran-boot r-cran-class r-cran-cluster r-cran-codetools r-cran-foreign r-cran-kernsmooth r-cran-lattice r-cran-mass r-cran-matrix r-cran-mgcv r-cran-nlme r-cran-nnet r-cran-rgtk2 r-cran-rpart r-cran-spatial r-cran-survival r-recommended \
     rake recordmydesktop rsync samba-libs sane-utils sc3-plugins-server scratch scribus scribus-data \
     sgml-base sgml-data shared-mime-info simple-scan socat sound-theme-freedesktop \
     spice-client-glib-usb-acl-helper sshfs ssl-cert sudo swell-foop \
     syslinux syslinux-common \
     system-config-printer system-config-printer-common system-config-printer-udev \
     t1utils tali \
     task-brazilian-portuguese task-brazilian-portuguese-desktop task-desktop task-laptop task-print-server \
     tcl tcl8.6 \
     testng \
     tk tk8.6 tk8.6-blt2.5 \
     ttf-bitstream-vera ttf-sjfonts \
     ubertooth ubertooth-firmware \
     ucf udisks2 unicon-imc2 uno-libs3 unpaper unzip update-inetd upower ure \
     usb-modeswitch usb-modeswitch-data usbmuxd usbutils \
     user-setup util-linux-locales uuid-runtime va-driver-all \
     vcdimager vdpau-driver-all vinagre vino \
     vlc vlc-bin vlc-data vlc-l10n vlc-plugin-base vlc-plugin-video-output \
     voikko-fi whois wireless-tools wodim wpasupplicant \
     x11-apps x11-common x11-session-utils x11-utils x11-xkb-utils x11-xserver-utils \
     xaos xapps-common xauth xbitmaps xbrlapi \
     xdg-user-dirs xdg-user-dirs-gtk xdg-utils \
     xdmx xdmx-tools \
     xfonts-100dpi xfonts-75dpi xfonts-base xfonts-encodings xfonts-scalable xfonts-unifont xfonts-utils \\
     xinit xinput-calibrator \
     xkb-data xml-core xnest \
     xorg xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra \
     xserver-common xserver-xephyr xserver-xorg xserver-xorg-core xserver-xorg-input-all \
     xserver-xorg-input-elographics xserver-xorg-input-joystick \
     xserver-xorg-input-libinput xserver-xorg-input-mutouch xserver-xorg-input-synaptics \
     xserver-xorg-input-void xserver-xorg-input-wacom xserver-xorg-input-xwiimote \
     xserver-xorg-legacy xserver-xorg-video-all xserver-xorg-video-amdgpu \
     xserver-xorg-video-ast xserver-xorg-video-ati xserver-xorg-video-cirrus \
     xserver-xorg-video-dummy xserver-xorg-video-fbdev xserver-xorg-video-intel \
     xserver-xorg-video-ivtv xserver-xorg-video-mach64 xserver-xorg-video-mga \
     xserver-xorg-video-neomagic xserver-xorg-video-openchrome xserver-xorg-video-qxl \
     xserver-xorg-video-r128 xserver-xorg-video-radeon xserver-xorg-video-savage \
     xserver-xorg-video-siliconmotion xserver-xorg-video-sisusb xserver-xorg-video-tdfx \
     xserver-xorg-video-trident xserver-xorg-video-vesa xserver-xorg-video-vmware \
     xvfb xxkb xz-utils yelp yelp-xsl zeitgeist-core zenity zenity-common \
     zip kpartx alsa-firmware-loaders amd64-microcode atmel-firmware \
     b43-fwcutter bluez-firmware dahdi-firmware-nonfree dfu-programmer \
     dns323-firmware-tools expeyes-firmware-dev firmware-adi \
     firmware-amd-graphics firmware-ath9k-htc firmware-ath9k-htc-dbgsym \
     firmware-atheros firmware-b43-installer firmware-b43legacy-installer \
     firmware-bnx2   firmware-bnx2x firmware-brcm80211 firmware-cavium \
     firmware-intel-sound firmware-intelwimax firmware-iwlwifi firmware-libertas \
     firmware-linux firmware-linux-free firmware-linux-nonfree \
     firmware-microbit-micropython-dl firmware-misc-nonfree firmware-myricom \
     firmware-netronome firmware-netxen  firmware-qcom-media firmware-qlogic \
     firmware-ralink  firmware-realtek firmware-samsung firmware-siano \
     firmware-ti-connectivity firmware-zd1211 grub-firmware-qemu \
     hannah-foo2zjs hdmi2usb-fx2-firmware hdmi2usb-mode-switch \
     intel-microcode ipxe-qemu midisport-firmware ovmf sigrok-firmware-fx2lafw \
     ubertooth-firmware ssh-askpass-gnome" \
     --source "false" \
     "${@}"
