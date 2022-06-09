
# download this file to your project folder and excute
# chmod +x generate-ios.sh
# then run using
# ./generate-ios.sh
# rm ~/Library/MobileDevice/Provisioning\ Profiles/*.mobileprovision
# cd /Users/uzairleo/Library/MobileDevice/Provisioning\ Profiles
# rm ~/Library/MobileDevice/Provisioning\ Profiles/*.mobileprovision
# steps for pod
# cd ios
# sudo arch -x86_64 gem install ffi for m1 
# then update the repo 
#  arch -x86_64 pod install --repo-update 
# then
# flutter clean;flutter pub get;
# flutter build defaults to --release
flutter build ios

# make folder, add .app then zip it and rename it to .ipa
mkdir -p Payload
mv ./build/ios/iphoneos/Runner.app Payload
zip -r -y Payload.zip Payload/Runner.app
mv Payload.zip Payload.ipa

# the following are options, remove Payload folder
rm -Rf Payload
# open finder and manually find the .ipa and upload to diawi using chrome
open .
open -a "Safari" https://www.diawi.com/
