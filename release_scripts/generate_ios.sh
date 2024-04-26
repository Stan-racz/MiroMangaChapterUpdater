gitReset="git reset --hard"
gitFetchAll="git fetch --all"
gitRebase="git pull --rebase origin main"

fastlaneDistribute="fastlane distribute"
flutterclean="fvm flutter clean"
pubget="fvm flutter pub get"


$gitReset
$gitFetchAll
$gitRebase

fvm flutter build ios

mkdir -p Payload
mv ../build/ios/iphoneos/Runner.app Payload
zip -r -y Payload.zip Payload/Runner.app
mv Payload.zip Payload.ipa

rm -Rf Payload

cd ../ios


$fastlaneDistribute
$flutterclean
$pubget