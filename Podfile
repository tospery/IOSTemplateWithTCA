source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '16.0'
use_frameworks!
inhibit_all_warnings!

target 'IOSTemplateWithTCA' do
  
  pod 'HiSwiftUI', '1.1.0'
  pod 'HiLog/SwiftyBeaver', '1.1.0'
  pod 'HiStats/Console', '1.1.0'

  pod 'Domain', :path => './Domain'
  pod 'RealmPlatform', :path => './RealmPlatform'
  pod 'NetworkPlatform', :path => './NetworkPlatform'
  
  pod 'R.swift', '~> 7.0'
  pod 'AlertToast-Hi', '~> 1.3.9'
  pod 'ExytePopupView', '~> 3.1'
  pod 'SwiftUI-WebView-Hi', '~> 0.3.0'
  pod 'FancyScrollView-Hi', '0.1.4-v1'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
    end
  end
end
