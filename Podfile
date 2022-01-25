# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'Meowclavas' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for Meowclavas
  
  # Add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'

  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
  
  # lottie animations
  pod 'lottie-ios'

  target 'MeowclavasTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'MeowclavasUITests' do
    # Pods for testing
  end

end
