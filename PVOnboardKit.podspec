Pod::Spec.new do |spec|
  spec.name             = 'PVOnboardKit'
  spec.platform         = :ios, '8.0'
  spec.version          = '0.1.0'
  spec.license          = { :type => 'MIT' }
  spec.homepage         = 'https://github.com/vpeschenkov/PVOnboardKit.git'
  spec.authors          = { 'Peschenkov Victor' => 'nerevarxx@gmail.com' }
  spec.summary          = 'Make an app tutorial as easy as possible😎!'
  spec.description      = 'PVOnboardKit allows to make an tutorial for you app, as easy as possible. As main concept uses UITableView. Also, for more customization PVOnboardKit uses TAPageControl instead of UIPageControl.'
  spec.source           = { :git => 'https://github.com/vpeschenkov/PVOnboardKit.git', :tag => spec.version.to_s }
  spec.source_files     = 'PVOnboardKit/{PV}*.{h,m}'
  spec.requires_arc     = true
  spec.framework        = 'Foundation', 'UIKit' 
  spec.dependency 'TAPageControl'
end
