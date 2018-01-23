#
# Be sure to run `pod lib lint atoulous2018.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'atoulous2018'
  s.version          = '0.1.0'
  s.summary          = 'd08 pod atoulous2018.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'its a long description of the pod d08 made by atoulous.'

  s.homepage         = 'https://github.com/atoulous/atoulous2018'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'atoulous' => 'atoulous@student.42.fr' }
  s.source           = { :git => 'https://github.com/atoulous/atoulous2018.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'atoulous2018/Classes/*.swift'
  
  s.resource_bundles = {
    'atoulous2018' => ['atoulous2018/Classes/**/*.xcdatamodeld']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
