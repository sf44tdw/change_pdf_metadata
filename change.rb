#pdfファイルの作成を行ったアプリケーションの情報(windowsで言えば、pdfファイルのプロパティのpdfタブのアプリケーション欄、作成者欄等)を書き換える。
#他ソフトで作ったpdfファイルを、scananap organizerの管理下に置くためのもの。
# gem install mini_exiftool


#入手元↓
#http://d.hatena.ne.jp/kenkitii/20120424/p1

require 'rubygems'
require 'mini_exiftool'

# 環境にあわせて書き換え。
 creatortool = "PFU ScanSnap Manager 4.0.10"
 producer = "Adobe PDF Scan Library 2.1"

#ホーム
 home_dir=ENV["HOME"]

#pdfファイルの置き場。
 path_to_workspace = home_dir+"/target"

 path_to_pdf = path_to_workspace+"/*.pdf" 

 puts path_to_pdf

 FileUtils.mkdir_p(path_to_workspace) unless FileTest.exist?(path_to_workspace)
 
Dir.glob(path_to_pdf) do |f|

	target = MiniExiftool.new(f)
	flag=0

        if target['Producer'] != producer
        	target['Producer'] = producer
		puts "#{f} => #{target['Producer']}"
		flag=flag+1
		puts flag
	end

        if target['Creator'] != creatortool
        	target['Creator'] = creatortool
		puts "#{f} => #{target['Creator']}"
		flag=flag+1
		puts flag
	end

	if target['CreatorTool'] != creatortool 
		target['CreatorTool'] = creatortool
		puts "#{f} => #{target['CreatorTool']}"
		flag=flag+1
		puts flag
	end

	if flag > 0
		target.save
		puts "#{f} was saved" 
		elsif flag==0
		puts "#{f} was not saved"
	end
end
