
Pod::Spec.new do |s|
s.name             = "WDSocialSDK"
s.version          = "0.0.1"
s.summary          = "Wechat,QQ,Webo Social share and authorization"
s.description      = <<-DESC
It is a Social SDK use on ios by Objective-c.
DESC
s.homepage         = "https://github.com/CoderWD/WDSocialSDK"
# s.screenshots      = ""
s.license          = 'MIT'
s.author           = { "Coder He" => "heweidong@outlook.com" }
s.source           = { :git => "https://github.com/CoderWD/WDSocialSDK.git", :tag => s.version.to_s }
# s.social_media_url = 'http://www.coderhe.cn'

s.platform     = :ios, '7.0'
s.requires_arc = true
s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

s.source_files = 'WDSocialSDK/*.{h,m}'
s.ios.vendored_frameworks = 'WDSocialSDK/WDSocialSDK.framework'
s.frameworks = 'Foundation', 'UIKit'

s.dependency 'WechatOpenSDK', '~> 1.7.8'
s.dependency 'WDTencentSDK'
s.dependency 'WDWeiboSDK'

end

