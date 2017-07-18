
Pod::Spec.new do |s|
s.name             = "WDSocialSDK"
s.version          = "0.0.2"
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
# s.ios.deployment_target = '5.0'
# s.osx.deployment_target = '10.7'
s.requires_arc = true
s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
s.source_files = 'WDSocialSDK/*.{h,m}'
# s.ios.vendored_frameworks = 'WDSocialSDK/TencentOpenAPI/TencentOpenAPI.framework'

# s.ios.exclude_files = 'Classes/osx'
# s.osx.exclude_files = 'Classes/ios'
# s.public_header_files = 'Classes/**/*.h'
s.frameworks = 'Foundation', 'UIKit','Security','SystemConfiguration','CoreGraphics','CoreTelephony','QuartzCore','ImageIO','CoreText','CFNetwork'
s.libraries = 'iconv', 'sqlite3','stdc++','z','c++'

# s.dependency 'WechatOpenSDK', '~> 1.7.8'

    s.subspec 'libWeiboSDK' do |wb|
        wb.source_files = 'WDSocialSDK/SDK/Weibo3.2.0'
    end

    s.subspec 'TencentOpenAPI' do |tc|
        tc.source_files = 'WDSocialSDK/SDK/Tencent3.2.3'
    end
    s.subspec 'TencentOpenAPI' do |wx|
        wx.source_files = 'WDSocialSDK/SDK/Wechat1.7.8'
    end


end

