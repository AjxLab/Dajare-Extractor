require 'open-uri'

def webDL(link, file)
  ## -----*----- Webからダウンロード -----*----- ##
  FileUtils.mkdir_p(File.dirname(file)) unless FileTest.exist?(File.dirname(file))
  begin
    open(file, 'wb') do |local_file|
      URI.open(link) do |web_file|
        local_file.write(web_file.read)
      end
    end

  rescue => e
    $logger.error(e.to_s)
  end
end


def scraping(doc, delay: 3, depth_limit: nil)
  ## -----*----- スクレイピング -----*----- ##

  # 検索フォーム
  doc.get(URL + '/#Search')
  doc.send(id: 'ViewQuantity', value: '1000')
  doc.submit(id: 'FormSearch')

  if depth_limit.nil?
    n_jokes = doc.xpath('//*[@id="PanelContentMain"]/p[2]/span').inner_text.to_i
    depth_limit =  n_jokes / 1000 + 1
  end

  mdap(depth_limit) {
    jokes = doc.css('.List').css('tr').drop(1)
    jokes.each do |el|
      p el.css('a').inner_text
      p el.css('.ListWorkScore').inner_text.to_f
    end

  }
  jokes = doc.css('.List').css('tr').drop(1)
  p jokes.length


  # DBにレコードを追加
  # $model.<table>.create(col1: value, col2: value...)

  # メールにアラートを出す
  # send_mail(to_address, subject, body)

  # ログ出力
  # $logger.<level>('log text')
end
