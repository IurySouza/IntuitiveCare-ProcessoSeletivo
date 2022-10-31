import scrapy
from scrapy.crawler import CrawlerProcess


#
#   Classe responsável pelo crawl da página
#   Consegue as informações a partir das tags <p> e <a>
#

class ProcRowSpider(scrapy.Spider):
    name = 'procrow_spider'
    start_urls = ['https://www.gov.br/ans/pt-br/assuntos/consumidor/o-que-o-seu-plano-de-saude-deve-cobrir-1/o-que-e-o-rol-de-procedimentos-e-evento-em-saude']

    def parse(self, response):
        for elems in response.css('p.callout'):
            try:
                yield {
                    'text': elems.css('a.internal-link::text').get(),
                    'file_link': elems.css('a.internal-link').attrib['href']
                }
            except:
                pass


#
#   Usa a spider definida anteriormente para conseguir os dados desejados e salva-os em um JSON
#

def runCrawl():
    process = CrawlerProcess(settings={
        'FEEDS': {
            'links.json': {'format': 'json'}
        }
    })

    process.crawl(ProcRowSpider)
    process.start()
