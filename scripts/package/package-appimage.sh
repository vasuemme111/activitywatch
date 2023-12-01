#!/bin/bash

# pick the latest zip
# NOTE: this assumes that the latest built zip is the only zip in the directory
ZIP_FILE=`ls ./dist/ -1 | grep zip | sort -r | head -1`
unzip ./dist/$ZIP_FILE

# fetch deps
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-x86_64.AppImage
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage

# create AppRun
echo '#!/bin/sh
DIR="$(dirname "$(readlink -f "${0}")")"
"${DIR}"/aw-qt "$@"' > SunDail/AppRun
chmod a+x ./SunDail/AppRun

# build appimage
./linuxdeploy-x86_64.AppImage --appdir SunDail --executable ./SunDail/aw-qt --output appimage --desktop-file ./SunDail/aw-qt.desktop --icon-file ./SunDail/media/logo/logo.png --icon-filename SunDail
APPIMAGE_FILE=`ls -1 | grep AppImage| grep -i SunDail`
cp -v $APPIMAGE_FILE ./dist/SunDail-linux-x86_64.AppImage
