
Pod::Spec.new do |s| 
	
	s.name 		= "Olla4iOS"
	s.version 	= "0.1.1"
	s.author 	= {'nonstriater' => '510495266@qq.com'}
	s.summary 	= "iOS framework"
	s.platform 	= :ios, '6.0'
	s.license	= "MIT"
	s.homepage 	= "http://weibo.com/ranwj"


	s.source 		= {:git => 'https://github.com/nonstriater/Olla4iOS.git' , :branch => 'master'}
	s.source_files 	= '**/*.{h,m}'
	s.requires_arc 	= true

	s.frameworks 	= 'AVFoundation','QuartzCore','CoreText','AssetsLibrary'
	s.library 		= 'sqlite3'


end 	
