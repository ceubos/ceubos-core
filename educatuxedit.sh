#!/bin/bash
# EducatuX Deb Maker
# 05/2017
# By Aderbal Botelho / EducatuX
######################################


case "$1" in

  --new)
    mkdir -p "$2/DEBIAN"
    echo 'Package: PACKAGE-NAME
Version: 1.0.0-0distribution0
Architecture: all
Maintainer: Your name <www.your-site.com>
Installed-Size: 100
#Depends:
Section: admin
Priority: optional
Description: Complete description about package' > "$2/DEBIAN/control"
  ;;


  --create)
    mkdir -p "$2/DEBIAN"
    echo "Package: $2
Version: 1.0.0-1EducatuX1
Architecture: all
Maintainer: Your Name <your@mail>
Section: admin
Priority: optional
Description: Describe your package" > "$2/DEBIAN/control"
  ;;

    --extract)
      if [ "$3" != "" ]; then
          dpkg-deb -R "$2" "$3/$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')"
      else
        dpkg-deb -R "$2" "$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')"
      fi
    ;;

    --compact)
      cd "$2/.."
      fakeroot dpkg-deb -b "$2"  "$(grep -ie "^Package:" -ie "Version:" -ie "Architecture:" $(echo "$2/DEBIAN/control") | sed 's|.*: ||g' | sed ':a;$!N;s/\n/-/;ta;')"
  exit
    ;;

    --editcontrol)
    dpkg-deb -R "$2" "/tmp/$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')"
    if [ -e "/usr/bin/xed" ]; then
        educatuxeditor="xed"
    elif [ -e "/usr/bin/gedit" ]; then
        educatuxeditor="gedit"
    else
        educatuxeditor="kate"
    fi
    $educatuxeditor "/tmp/$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')/DEBIAN/control"
    fakeroot dpkg-deb -b "/tmp/$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')" "$(echo "$2" | sed 's|.deb$|-EducatuX-modified.deb|g')"
    rm -Rf "/tmp/$(dpkg-deb -W "$2" | sed 's|\t|-|g;s| ||g')"
  exit
    ;;

    --help)
  echo "
  educatuxedit --create package_name
  educatuxedit --extract package.deb
  educatuxedit --compact folder_package
  educatuxedit --editcontrol package.deb
"
  exit
    ;;

esac
