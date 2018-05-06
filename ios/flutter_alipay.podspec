#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_alipay'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter Alipay plugin.'
  s.description      = <<-DESC
A Flutter Alipay plugin, that supports using alipay sdk in Flutter.
                       DESC
  s.homepage         = 'https://github.com/jzoom/flutter_alipay'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'JZoom' => 'jzoom8112@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AliPay'
  
  s.ios.deployment_target = '8.0'
end

