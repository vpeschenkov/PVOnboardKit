Pod::Spec.new do |s|
  s.name             = 'PVOnboardKit'
  s.platform         = :ios, '8.0'
  s.version          = '1.1.1'
  s.license          = { :type => 'MIT' }
  s.homepage         = 'https://github.com/vpeschenkov/PVOnboardKit.git'
  s.authors          = { 'Victor Peschenkov' => 'nerevarxx@gmail.com' }
  s.summary          = 'PVOnboardKit is a framework that allows you to add your own walkthrough/intro/tutorial into your app.'
  s.source           = { :git => 'https://github.com/vpeschenkov/PVOnboardKit.git', :tag => s.version.to_s }
  s.source_files     = 'PVOnboardKit/{PV}*.{h,m}'
  s.requires_arc     = true
  s.framework        = 'Foundation', 'UIKit'
  s.dependency 'TAPageControl'
end
