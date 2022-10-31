import scraper
import downloader
import shutil
import os
from pathlib import Path


#
#   Cria o diretório tmp em que os arquivos temporários serão salvos
#   Faz a chamada das funções de crawling, download e compressão
#   Deleta a pasta tmp juntamente com seus arquivos, bem como o JSON
#

def main():
    Path('tmp/').mkdir(parents=True, exist_ok=True)
    scraper.runCrawl()
    filenames = downloader.downloadFiles()
    downloader.compress(filenames)
    shutil.rmtree('tmp/')
    os.remove('links.json')
    print('Arquivos temporários deletados')


if __name__ == '__main__':
    main()
