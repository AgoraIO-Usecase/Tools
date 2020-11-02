Pod::Spec.new do |spec|
  spec.name         = "AgoraLog"
  spec.version      = "1.0.0"
  spec.summary      = "AgoraLogger can filter log and print on console. It also write all logs to file."
  spec.homepage     = "https://github.com/AgoraIO-Usecase/Tools/"
  spec.license      = "MIT"
  spec.author       = { "CavanSu" => "403029552@qq.com" }
  spec.ios.deployment_target = "10.0"
  spec.osx.deployment_target = "10.12"
  spec.source       = { :git => "https://github.com/AgoraIO-Usecase/Tools.git", :tag => "#{spec.version}" }

  spec.source_files  = "AgoraLog-Objective-C/sources/*.{h,m,swift}", "sources/*.{h,m,swift}"
  spec.dependency "CocoaLumberjack", "~> 3.6.1"
  spec.module_name   = 'AgoraLog'
  spec.swift_version = '4.0'
end
