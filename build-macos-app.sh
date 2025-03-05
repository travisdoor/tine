#!/bin/bash
blc -build --release
echo Creating application bundle
rm -r -f tine-macos-arm64
mkdir tine-macos-arm64
mkdir tine-macos-arm64/Tine.app
mkdir tine-macos-arm64/Tine.app/Contents
mkdir tine-macos-arm64/Tine.app/Contents/MacOS
mkdir tine-macos-arm64/Tine.app/Contents/Resources
cp Tine tine-macos-arm64/Tine.app/Contents/MacOS/Tine
cp Info.plist tine-macos-arm64/Tine.app/Contents
cp icon/tine.icns tine-macos-arm64/Tine.app/Contents/Resources/tine.icns
dylibbundler -b -d tine-macos-arm64/Tine.app/Contents/MacOS -p @executable_path/ -x tine-macos-arm64/Tine.app/Contents/MacOS/Tine
chmod +x tine-macos-arm64/Tine.app/Contents/MacOS/Tine
ln -s /Applications tine-macos-arm64/Applications
hdiutil create -volname "Tine" -srcfolder tine-macos-arm64 -format UDZO -o Tine.dmg
echo Done