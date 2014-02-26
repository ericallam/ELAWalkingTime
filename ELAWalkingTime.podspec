Pod::Spec.new do |s|
  s.name             = "ELAWalkingTime"
  s.version          = "0.1.0"
  s.summary          = "A simple wrapper around MKDirections for getting Walking time ETA directions"
  s.description      = <<-DESC
                        A simple wrapper around MKDirections for getting Walking time ETA directions.
                       DESC
  s.homepage         = "https://github.com/ericallam/ELAWalkingTime"
  s.license          = 'MIT'
  s.author           = { "Eric Allam" => "eallam@icloud.com" }
  s.source           = { :git => "https://github.com/ericallam/ELAWalkingTime.git", :tag => s.version.to_s }
  s.requires_arc = true

  s.source_files = 'ELAWalkingTime'
  s.public_header_files = 'ELAWalkingTime/**/*.h'
end
