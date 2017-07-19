
Pod::Spec.new do |s|
s.name             = "WDSocialSDK"
s.version          = "0.0.7"
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

s.subspec 'Component' do |sdk|
    sdk.source_files = 'WDSocialSDK/SDK/Wechat1.7.8'
    sdk.source_files = 'WDSocialSDK/SDK/Weibo3.2.0'
end

s.source_files = 'WDSocialSDK/*.{h,m}'
s.source_files = 'WDSocialSDK/SDK/Weibo3.2.0/*.{h,m}'
s.source_files = 'WDSocialSDK/SDK/Wechat1.7.8/*.{h,m,txt}'

s.ios.vendored_frameworks = 'WDSocialSDK/SDK/Tencent3.2.3/TencentOpenAPI.framework','WDSocialSDK/WDSocialSDK.framework'
s.vendored_libraries = 'WDSocialSDK/SDK/Wechat1.7.8/libWeChatSDK.a', 'WDSocialSDK/SDK/Weibo3.2.0/libWeiboSDK.a'
s.resource = 'WDSocialSDK/SDK/Weibo3.2.0/WeiboSDK.bundle'

s.frameworks = 'Foundation', 'UIKit','Security','SystemConfiguration','CoreGraphics','CoreTelephony','QuartzCore','ImageIO','CoreText','CFNetwork'
s.libraries = 'iconv', 'sqlite3','stdc++','z','c++'

end

