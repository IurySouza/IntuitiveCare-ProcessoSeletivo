import conversion


def main():
    menu = int(input('''
Foram desenvolvidas duas funções que realizam a tarefa proposta, ambas utilizando o pacote Tabula
1. Implementação própria, cumprindo os objetivos bônus
2. Função já pronta. Apesar de não cumprir os objetivos bônus, foi tão rápido de se desenvolver que julguei digno de nota.   

'''
    ))

    print('\nTransformando arquivo...')

    if menu == 1:
        conversion.myConversion()
    elif menu == 2:
        conversion.quickConversion()
    else:
        print('Opção inválida')


if __name__ == '__main__':
    main()
