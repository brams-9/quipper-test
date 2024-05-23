# Uncomment the next line to define a global platform for your project
 platform :ios, '16.2'

target 'QuipperTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Kingfisher'
  # Pods for QuipperTest

  target 'QuipperTestTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'QuipperTestUITests' do
    # Pods for testing
  end

 post_install do |installer|   
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end

end
