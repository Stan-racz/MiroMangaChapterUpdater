cd ../android

fastlaneBuild="fastlane build"
fastlaneDistribute="fastlane distributetest"
flutterclean="fvm flutter clean"
pubget="fvm flutter pub get"

$fastlaneBuild
$fastlaneDistribute
$flutterclean
$pubget
