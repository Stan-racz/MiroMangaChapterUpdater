cd ../android

fastlaneBuild="fastlane build"
#fastlaneIncrementBuildNumber="fastlane increase_build_number"
fastlaneDistribute="fastlane distributetest"
flutterclean="fvm flutter clean"
pubget="fvm flutter pub get"

$fastlaneBuild
$fastlaneDistribute
$flutterclean
$pubget
