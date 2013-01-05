Pod::Spec.new do |s|
  s.name         = "UIView+Genie"
  s.version      = "0.1"
  s.summary      = "An OSX style genie effect inside your iOS app."
  s.homepage     = "https://github.com/Ciechan/BCGenieEffect"
  s.license      = 'MIT'
  s.author       = { "Bartosz Ciechanowski" => "ciechan@gmail.com" }
  s.source       = { :git => "https://github.com/Ciechan/BCGenieEffect.git", :tag => "0.1" }
  s.platform     = :ios
  s.source_files = 'UIView+Genie.{h,m}'
  s.requires_arc = true
end
