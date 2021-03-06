#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_cmcc_auth'
  s.version          = '0.0.1'
  s.summary          = 'A mobile auth Flutter plugin.'
  s.description      = <<-DESC
A mobile auth Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.ios.vendored_frameworks = 'TYRZSDK.framework'
  s.ios.resource_bundles = {'TYRZResource' => ['TYRZSDK.framework/TYRZResource.bundle/*.png'] }
  s.ios.deployment_target = '9.0'
  s.static_framework = true

  s.prefix_header_contents = '#import <TYRZSDK/UACustomModel.h>','#import <flutter_cmcc_auth/FlutterCmccAuthPlugin.h>'
end
