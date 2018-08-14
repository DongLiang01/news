# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'news' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'   #网络框架
  pod 'SwiftyJSON'
  pod 'HandyJSON'    #model转换
  pod 'Kingfisher'   #图片加载
  pod 'IBAnimatable'
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end
  pod 'SwiftTheme'
  pod 'RxSwift'
  pod 'RxCocoa'
end
