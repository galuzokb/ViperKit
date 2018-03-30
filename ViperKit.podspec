Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.name         = "ViperKit"
  s.version      = "0.0.7"
  s.summary      = "ViperKit"
  s.description  = "ViperKit description"
  s.homepage     = "https://github.com/galuzokb/ViperKit"
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENCE.md" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "Kirill Galuzo" => "galuzokb@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.platform     = :ios, "9.3"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/galuzokb/ViperKit.git", :tag => "0.0.8" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "ViperKit", "ViperKit/**/*.{h,m,swift}"
  
  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.dependency 'Dip'
  s.dependency 'Dip-UI'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
