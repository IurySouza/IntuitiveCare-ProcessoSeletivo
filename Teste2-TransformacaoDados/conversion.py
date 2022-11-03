from cmath import isnan
import csv
from sre_compile import isstring
import tabula
import zipfile


#
#   Obtém-se um DataFrame a partir da leitura da tabela do PDF
#   É feita a substituição de OD e AMB por Seg. Odontológica e Seg. Ambulatorial, respectivamente
#       Os valores chaves são colocados em uma lista
#   Lê-se o DataFrame, armazenando os dados em listas de listas 
#   Gera-se o CSV e é realizada a compressão do arquivo
#

def myConversion():
    df = tabula.read_pdf('Anexo-I.pdf', pages='all', multiple_tables=False)
    keys = df[0].keys()
    keys_csv = list(map(lambda x: x.replace('OD', 'Seg. Odontológica').replace('AMB', 'Seg. Ambulatorial'), keys))

    data = []

    for row in range(len(df[0])):
        data.append([])
        for key in keys:
            value = df[0][key][row]
            if not isstring(value):
                if isnan(value):
                    value = None
            data[row].append(value)

    with open('Anexo-I.csv', 'w', encoding='UTF8') as file:
        writer = csv.writer(file)
        writer.writerow(keys_csv)
        writer.writerows(data)

    compress()


#
#   Método que se utiliza de uma função nativa do Tabula para gerar o CSV
#

def quickConversion():
    tabula.convert_into('Anexo-I.pdf', 'Anexo-I.csv', pages='all')
    compress()


#
#   Realiza a compressão do arquivo CSV para arquivo ZIP
#

def compress():
    compression = zipfile.ZIP_DEFLATED
    zf = zipfile.ZipFile('Teste_IurySouza.zip', mode='w')

    try:
        zf.write('Anexo-I.csv', 'Anexo-I.csv', compress_type=compression)
    except FileNotFoundError:
        print('O arquivo não foi encontrado')
    finally:
        zf.close()
        print('Arquivo ZIP gerado')