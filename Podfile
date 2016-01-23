source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
inhibit_all_warnings!

link_with 'BlockHunt'

pod 'BPXLUUIDHandler', '~> 0.0'
pod 'CocoaLumberjack', '2.2'
pod 'Crashlytics', '~> 3.3'
pod 'Fabric', '~> 1.5'
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
pod 'FBSDKShareKit'
pod 'GRKAlertBlocks', '~> 1.0'
pod 'HSLUpdateChecker', '~> 1.0.2'
pod 'LocationHelper', '~> 0.0.1'
pod 'MBProgressHUD', '~> 0.8'
pod 'MGSwipeTableCell', '~> 1.5'
pod 'QuickDialog', '~> 1.0'
pod 'QuickDialog/Extras', '~> 1.0'
pod 'RestKit', '~> 0.24'
pod 'RKCLLocationValueTransformer', '~> 1.1'
#pod 'SocketRocket', '~> 0.3'
pod 'SwipeView'
#pod 'SVPullToRefresh', '~> 0.4'
pod 'TBAlertController', '~> 2.0'
pod 'YLMoment', '~> 0.5'
pod 'SwipeView'
pod 'MZTimerLabel'
pod 'PaperTrailLumberjack', :git => 'https://github.com/greenbits/papertrail-lumberjack-ios.git'

# avoids issues with objc_msgSend
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = "NO"
        end
    end
end

target :'BlockHuntTests', :exclusive => true do
	platform :ios, '7.0'
    pod 'KIF-Kiwi'
end

