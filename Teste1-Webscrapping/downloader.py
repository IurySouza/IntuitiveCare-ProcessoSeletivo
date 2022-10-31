import requests
import json
import zipfile


#
#   Lê o arquivo JSON e o transforma em um array de dicionários do Python
#   Gera o caminho e nome com extensão dos arquivos a serem gerados
#   Acessa a URL e faz o download do arquivo
#   Retorna os caminhos dos arquivos pois os mesmos são necessários na função de compressão
#

def downloadFiles():
    file = open('links.json', 'r')
    links_list = json.loads(file.read())
    extensions = [0, 'pdf', 'xlsx', 'pdf', 'pdf', 'pdf']
    filenames = []
    
    for i in range(1, 6):
        # Essa manipulação retira o (.pdf) ou (.xlsx) que estavam presentes no fim dos textos (e não eram a extensão) que servirão como nome dos arquivos
        # Além disso, adiciona o caminho tmp/ e a extensão ao nome
        filename = f"tmp/{' '.join(links_list[i]['text'].split(' ')[:-1])}.{extensions[i]}"
        filenames.append(filename)

        URL = links_list[i]['file_link']
        response = requests.get(URL)
        open(filename, 'wb').write(response.content)
        
    return filenames


#
#   Faz a compressão de todos os arquivos no diretório tmp
#

def compress(filenames):
    compression = zipfile.ZIP_DEFLATED
    zf = zipfile.ZipFile('Anexos I-IV.zip', mode='w')

    try:
        for filename in filenames:
            # filename.split('/')[1] passa apenas o nome do arquivo, sem o caminho
            zf.write(filename, filename.split('/')[1], compress_type=compression)
    except FileNotFoundError:
        print('O arquivo não foi encontrado')
    finally:
        zf.close()
        print('Arquivo ZIP gerado')