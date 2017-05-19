SCRIPTS_DIR=`dirname $0`
echo "Running xcodebuild with UI Coverage Fix"
remove codesigning from xcodebuild so we can inject a library into it
pushd $TMPDIR
echo "Removing xcodebuild code signature"
cp /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild ./
codesign --force --sign - --timestamp=none ./xcodebuild
cp -f ./xcodebuild /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
popd

echo "Terminating Any Running Simulators"
killall -9 Simulator
echo "Erasing Derived Data"
rm -rf $SCRIPTS_DIR/../DerivedData/

echo "Running xcodebuild with lldb to inject fix library"
xcrun lldb -f /Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -s "${SCRIPTS_DIR}/coverageFix.lldb"

# test coverage with:
xcrun llvm-cov report -instr-profile=$SCRIPTS_DIR/DerivedData/Slate/Build/Intermediates/CodeCoverage/Coverage.profdata $SCRIPTS_DIR/../DerivedData/Slate/Build/Intermediates/CodeCoverage/Products/Debug-iphonesimulator/Slate.app/Slate | grep BaseCaptureViewController.swift
