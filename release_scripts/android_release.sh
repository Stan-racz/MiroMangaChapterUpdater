cd ../android

gitReset="git reset --hard"
gitFetchAll="git fetch --all"
gitRebase="git pull --rebase origin main"

fastlaneBuild="fastlane build"

fastlaneDistribute="fastlane distribute"
flutterclean="fvm flutter clean"
pubget="fvm flutter pub get"

$gitReset
$gitFetchAll
$gitRebase

$fastlaneBuild
$fastlaneDistribute
$flutterclean
$pubget
