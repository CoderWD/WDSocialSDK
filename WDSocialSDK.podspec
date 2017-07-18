Pod::Spec.new do |spec|
spec.name         = 'WDSocialSDK'
spec.platform     = :ios, '7.0'
spec.requires_arc = true
spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
spec.version      = '0.0.1'
spec.license      = { :type => 'MIT' }
spec.homepage     = 'https://github.com/CoderWD/WDSocialSDK'
spec.authors      = { 'Coder He' => 'heweidong@outlook.com' }
spec.summary      = 'Wechat,QQ,Webo Social share and authorization'
spec.source       = { :https://github.com/CoderWD/WDSocialSDK.git', :tag => spec.version.to_s }
spec.source_files = 'WDSocialSDK.{h,m}'
spec.frameworks = 'Foundation', 'UIKit'
spec.ios.vendored_frameworks = 'WDSocialSDK/TencentOpenAPI/TencentOpenAPI.framework'
spec.dependency 'WechatOpenSDK', '~> 1.7.8'
spec.dependency 'WeiboSDK', '~> 3.2.0'
end
