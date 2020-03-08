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
    depth_limit = n_jokes / 1000 + 1
  end

  n = 0

  mdap(depth_limit) { |i|
    jokes = doc.css('.List').css('tr').drop(1)
    p jokes.length
    jokes.each do |el|
      # ダジャレの情報
      joke = {
        joke: el.css('a').inner_text,
        score: el.css('.ListWorkScore').inner_text.to_f,
        author: el.css('.ListWorkAuthor').inner_text,
        is_joke: true
      }

      # 新規ダジャレの場合 -> DBに保存
      if $model.jokes.find_by(**joke).nil?
        $model.jokes.create(**joke)
        n += 1
      end
    end

    # 次ページへ移動
    if i != depth_limit-1
      doc.send(id: 'ButtonPageNext', click: true)
      doc.submit(id: 'FormButtonNext')
      sleep delay
    end
  }

  $logger.info("取得完了：新規#{n}件")
end
