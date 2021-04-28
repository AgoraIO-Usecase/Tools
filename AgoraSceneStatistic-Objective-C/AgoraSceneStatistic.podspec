Pod::Spec.new do |spec|
  spec.name         = "AgoraSceneStatistic"
  spec.version      = "1.0.1"
  spec.summary      = "AgoraSceneStatistic uploads statistic data to agora server"
  spec.homepage     = "https://github.com/AgoraIO-Usecase/Tools/"
  spec.license      = "MIT"
  spec.author       = { "CavanSu" => "403029552@qq.com" }
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  spec.source       = { :git => "https://github.com/AgoraIO-Usecase/Tools.git", :tag => 'statistic_oc_' + "#{spec.version.to_s}" }

  spec.source_files  = "AgoraSceneStatistic-Objective-C/sources/*.{h,m,swift}", "sources/*.{h,m,swift}"
  spec.public_header_files = "sources/*.h"
  spec.module_name   = 'AgoraSceneStatistic'
  spec.dependency "Armin", "1.0.6"
end
