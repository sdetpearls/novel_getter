require 'net/http'
require 'open-uri'
require 'nokogiri'

# 获取小说内容
class NovelGetter
    # 获取目录页
    def biquge_dir_getter(dir_url)
        @dir_array = []
        @book_title=nil

        dir_source = Nokogiri::HTML(open(dir_url),nil,'gbk')
        @book_title = dir_source.at_xpath('//div[@id="info"]/h1').content.to_s.encode('utf-8')
        Dir.mkdir(@book_title)
        dir_list = dir_source.at_xpath('//div[@id="list"]').css('dd a')

        dir_list.each do |a_list|
            title = a_list.content.to_s.encode('utf-8')
            url = 'http://www.biquge.com.tw' + a_list['href'].to_s.encode('utf-8')
            @dir_array << { title: title, url: url }
        end
    end

    # 获取内容页
    def biquge_content_getter
            i =1
            @dir_array.each do |page|
                # if i >1
                #     break 
                # end
                page_source = Nokogiri::HTML(open(page[:url]),nil,'gbk')
                page_content = page_source.xpath('//div[@id="content"]').to_s.encode('utf-8')
                page_content.gsub!(/<.*?>/, '')
                page_content.gsub!(/\r\n\r\n/, '<br/>')
                page_body = '<div id="title">' + page[:title] + '</div><hr/><div id="content">' + page_content + '</div>'
                
                # 写入文件
                File.open("./#{@book_title}/#{i}--#{page[:title]}.html","a+") do |file|
                    file << '<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"><link rel="stylesheet" type="text/css" href="../biquge.css"></head><body>'
                    file << page_body
                    file << "<hr/><div id=\"next\"><a href=\"#{i+1}--#{@dir_array[i][:title]}.html\">下一章——#{@dir_array[i][:title]}</a></div></body></html>"
                end
                puts "#{@book_title} - the #{i}th part downloaded+++"
                i=i+1
            end
    end
end

novel_spy = NovelGetter.new()
# 蛊真人
novel_spy.biquge_dir_getter('http://www.biquge.com.tw/1_1314/')
novel_spy.biquge_content_getter
# 异常生物见闻录
novel_spy.biquge_dir_getter('http://www.biquge.com.tw/4_4029/')
novel_spy.biquge_content_getter
# 史上第一混乱
novel_spy.biquge_dir_getter('http://www.biquge.com.tw/0_227/')
novel_spy.biquge_content_getter
# 从前有座灵剑山
novel_spy.biquge_dir_getter('http://www.biquge.com.tw/3_3302/')
novel_spy.biquge_content_getter