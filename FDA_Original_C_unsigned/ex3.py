# -*- coding: utf-8 -*-
"""
Desenvolva uma aplicação que permite realizar o cálculo de CRC para uma palavra
de 8 bits usando o polinômio x3 + x2 + x. Deverá ser implementado o detector de
erro. Dica: utilize operadores de bitwise para implementar o cálculo.
"""
def xor(a, b):
    result = ''
    for i in range(len(a)):
        bSum = int(a[i]) + int(b[i])
        if bSum == 1:
            result += '1'
        else:
            result += '0'
    return result

def removeZeros(data):
    for i in range(len(data)):
        if data[i] == '1':
            return data[i:]

def binaryDivision(data, crc):
    dataAux = removeZeros(data)
    resultXor = xor(dataAux[:4], crc)
    result = resultXor + dataAux[4:]
    if len(result) <= 4:
        return result[1:]
    else:
        return binaryDivision(result, crc)
    
if __name__ == '__main__':
    data = '10011010'
    crc = '1101'
    
    data += '000'
    
    print(binaryDivision(data, crc))

def crc(data, crc):
    crc_size = len(crc)
    data_part = 0
    i = 0
    j = 0
    for v in range(data):
        data_part += 1
        if data_part == crc_size :
            j = j + data_part
            xor(data[i:j] ,crc)
        
"""
def bin_crc(polynomial):
    for v in polynomial:
"""      

if __name__ == "__main__":
    data = "0"
    data = "10011010"
    while len(data) != 8:
        data = input("Palvra de 8 bits: ")
        if len(data) != 8 : print("Digite uma palavra de 8 bits exatamente!")
        
        # p = input("Digite o polinomio (ex.: x3+x2+1): ")
        
    p = "x3+x+1"    
    pv = p.split("+") # lista das varivaveis
    degrees = []
    for v in pv:    # caminha em cada variavel do polinomio
        if len(v) > 1:  # caso tenha algum grau
            degrees.append(v[1]) # coloca o grau de cada variavel em uma lista
        else:
            if v[0] == "x" : degrees.append('1')  # caso seja de 1º grau
            else : degrees.append('0')            # caso não tenha grau
    
    print(degrees)
    print("Palvra", data)
    H_degree = int(degrees[0])  # pega o maior grau do polinomio
    
    crc = "1011" # polinomio em binario
    new_data = data
    for i in range(H_degree):   # adicionando os zeros referente ao maior grau do polinomio
        new_data = new_data + "0"

    
    