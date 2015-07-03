
Pod::Spec.new do |s| 
	
	s.name 		= "Olla4iOS"
	s.version 	= "0.1.2"
	s.author 	= {'nonstriater' => '510495266@qq.com'}
	s.summary 	= "iOS framework"
	s.platform 	= :ios, '6.0'
	s.license	= "MIT"
	s.homepage 	= "http://weibo.com/ranwj"

	s.requires_arc 	= true
	s.frameworks 	= 'AVFoundation','QuartzCore','CoreText','AssetsLibrary'
	s.library 		= 'sqlite3'

	s.source 		= {:git => 'https://github.com/nonstriater/Olla4iOS.git', :tag => 'v0.1.2'}
  	s.source_files = 'Olla4iOS/*.h'

  	s.dependency 'SDWebImage', '~> 3.7.2'
  	s.dependency 'FMDB', '~> 2.5'
  	s.dependency 'MBProgressHUD', '~> 0.9.1'
  	s.dependency 'CocoaLumberjack', '~> 2.0.1'


  	s.subspec 'foundation' do |ss|
  		ss.source_files = 'Olla4iOS/foundation/**/*.{h,m}'
  	end 

	s.subspec 'system' do |ss|
		ss.source_files = 'Olla4iOS/system/**/*.{h,m}'

  	end 

  	s.subspec 'application' do |ss|
  		ss.source_files = 'Olla4iOS/application/**/*.{h,m}'
  	end 

end 	
