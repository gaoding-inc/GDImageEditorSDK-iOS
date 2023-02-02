#
# Be sure to run `pod lib lint GDImageEditorSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GDImageEditorSDK'
  s.version          = '0.2.1'
  s.summary          = '稿定Web编辑器SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '稿定Web编辑器SDK'
  s.homepage         = 'https://github.com/gaoding-inc/GDImageEditorSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xinqing' => '826276259@qq.com' }
  s.source           = { :git => 'https://github.com/gaoding-inc/GDImageEditorSDK-iOS.git', :tag => s.version.to_s }
  s.platform = :ios, '9.0'
  s.requires_arc = true
  s.vendored_frameworks = 'GDImageEditorSDK.framework'
  s.frameworks = 'WebKit'
end
