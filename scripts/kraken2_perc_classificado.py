import matplotlib.pyplot as plt

#nome das amostras
amostras = ['ACBM1', 'ACBM2', 'ACBM3',
            'ALBM1', 'ALBM2', 'ALBM3',
            'ASBM1', 'ASBM2', 'ASBM3',
            'ABBM1', 'ABBM2', 'ABBM3']

#porcentagens respectivas às amostras
pct_classified = [50.8, 82.8, 86.2, 28.3, 5.5, 4.2, 11.9, 13.8, 49.8, 73.9, 18.8, 91.0]
pct_unclassified = [49.2, 17.2, 13.8, 71.7, 94.5, 95.8, 88.1, 86.2, 50.2, 26.1, 81.2, 9.0]

#tamanho da "folha", para o gráfico não ficar espremido 
plt.figure(figsize=(12, 6))

#coloquei as barras lado a lado
#a primeira barra (Classified) 
posicoes_class = list(range(len(amostras)))

#a segunda barra (Unclassified) ganha um "+ 0.4" para ir para o lado
posicoes_unclass = [pos + 0.4 for pos in posicoes_class]

#nomes no eixo x e barras com largura 0.4
plt.bar(posicoes_class, pct_classified, width=0.4, color='#0072B2', label='Classified')
plt.bar(posicoes_unclass, pct_unclassified, width=0.4, color='#E69F00', label='Unclassified')

#nome do eixo y
plt.ylabel('Porcentagem (%)', fontweight='bold')

#desloquei o texto da amostra em 0.2 para ele ficar bem no meio das duas barras
posicoes_xtick = [pos + 0.2 for pos in posicoes_class]
plt.xticks(posicoes_xtick, amostras, fontsize=10)

#escrevi o nome das formigas em itálico logo abaixo das amostras
plt.text(1.2, -12, 'Capiguara', ha='center', fontsize=12, fontstyle='italic')
plt.text(4.2, -12, 'Laevigata', ha='center', fontsize=12, fontstyle='italic')
plt.text(7.2, -12, 'Sexdens', ha='center', fontsize=12, fontstyle='italic')
plt.text(10.2, -12, 'Bisphaerica', ha='center', fontsize=12, fontstyle='italic')

#coloquei as porcentagens nas barras
for container in plt.gca().containers:
    plt.gca().bar_label(container, fmt='%.1f%%', label_type='edge', padding=1, fontsize=8)

plt.title('Qualidade da Filtragem das Amostras - Kraken/QC', fontweight='bold', fontsize=14)

plt.legend(loc='upper center', bbox_to_anchor=(0.5, -0.15), ncol=2)
plt.subplots_adjust(bottom=0.22)

plt.show()