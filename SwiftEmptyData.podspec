
Pod::Spec.new do |s|
  s.name             = 'SwiftEmptyData'
  s.version          = '0.9.0'
  s.summary          = 'A short description of SwiftEmptyData.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/SwiftEmptyData'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackiehu' => 'jackie' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftEmptyData.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*'
 
  s.dependency 'SnapKit'

  s.swift_versions     = ['4.2','5.0','5.1','5.2']
  s.requires_arc = true
end
