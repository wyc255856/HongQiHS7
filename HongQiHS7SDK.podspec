#
#  Be sure to run `pod spec lint HongQiHS7SDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HongQiHS7SDK"
  s.version      = "1.0.3"
  s.summary      = "A short description of HongQiHS7SDK."

  s.description  = <<-DESC
		   HongQi HS7 Easy Fast!
                   DESC

  s.homepage     = "http://EXAMPLE/HongQiHS7SDK"

  s.license      = "Copyright (c) 2019年 HongQiHS7SDK. All rights reserved."

  s.author             = { "张三" => "zhangsan0103@gmail.com" }

  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

   s.source       = { :git => "https://github.com/wyc255856/HongQiHS7.git", :tag => "#{s.version}" }



   s.source_files  = "HongQiHS7SDK", "HongQiHS7SDKiOS/HongQiHS7SDK/*.{h,m,c}"
  s.exclude_files = "Classes/Exclude"
  s.resource = "HongQiHS7SDKiOS/HongQiHS7SDK/HS7CarResource.bundle"

end
