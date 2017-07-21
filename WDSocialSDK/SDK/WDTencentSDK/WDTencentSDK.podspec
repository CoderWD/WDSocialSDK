
Pod::Spec.new do |s|
s.name             = "WDTencentSDK"
s.version          = "1.0.0"
s.summary          = "Tencent sdk 3.2.3"
s.description      = <<-DESC
It is a Tencent SDK use on ios by Objective-c.
DESC
s.homepage         = "https://github.com/CoderWD/WDTencentSDK"
# s.screenshots      = ""
s.license          = 'MIT'
s.author           = { "Coder He" => "heweidong@outlook.com" }
s.source           = { :git => "https://github.com/CoderWD/WDTencentSDK.git", :tag => s.version.to_s }
# s.social_media_url = 'http://www.coderhe.cn'

s.platform     = :ios, '7.0'
s.requires_arc = true
s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

s.ios.vendored_frameworks = 'TencentOpenAPI.framework'

s.frameworks = 'Foundation', 'UIKit','Security','SystemConfiguration','CoreGraphics','CoreTelephony'


s.libraries = 'iconv', 'sqlite3','stdc++','z','c++'

end
