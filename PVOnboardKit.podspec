Pod::Spec.new do |s|
  s.name             = 'PVOnboardKit'
  s.platform         = :ios, '8.0'
  s.version          = '0.2.0'
  s.license          = { :type => 'MIT' }
  s.homepage         = 'https://github.com/vpeschenkov/PVOnboardKit.git'
  s.authors          = { 'Victor Peschenkov' => 'nerevarxx@gmail.com' }
  s.summary          = 'Make an app tutorial as easy as possible😎!'
  s.description      = 'PVOnboardKit allows to make an tutorial for you app, as easy as possible. As main concept uses UITableView.Also, for more customization PVOnboardKit uses TAPageControl instead of UIPageControl.'
  s.source           = { :git => 'https://github.com/vpeschenkov/PVOnboardKit.git', :tag => s.version.to_s }
  s.source_files     = 'PVOnboardKit/{PV}*.{h,m}'
  s.requires_arc     = true
  s.framework        = 'Foundation', 'UIKit'
  s.dependency 'TAPageControl'
end
