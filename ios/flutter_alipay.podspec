#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_alipay.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_alipay'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for alipay.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://github.com/best-flutter/flutter_alipay'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'jzoom8112@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  s.dependency 'AlipaySDK-iOS'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
