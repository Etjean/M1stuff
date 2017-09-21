#seq = "gtgggaatgccaattataggggtgccgaggtgccttataaaacccttttctgtgcctgtgacatttcctttttcggtcaaaaagaatatccgaattttagatttggaccctcgtacagaagcttattgtctaagcctgaattcagtctgctttaaacggcttccgcggaggaaatatttccatctcttgaattcgtacaacattaaacgtgtgttgggagtcgtatactgttagggtctgtaaacttgtgaactctcggcaaatgccttggtgcaattacgtaatttt"

import code

def get_compo(seq):
    compo = {}
    for aa in seq:
        if aa in compo:
            compo[aa] += 1
        else:
            compo[aa] = 1
    return compo

#######
#### main
#######
with open("seq_sacch.fasta","r") as f:
    f.readline()
    seq = f.read()

seq = seq.replace("\n","")

start = False ; seq_prot = ""
for i in range(0,len(seq),3):
    codon = seq[i:i+3]
    if codon == 'atg':
         start = True
    if code.gencode[codon] == '_':
        start = False
    if start:
        #print codon, gencode[codon]
        seq_prot += code.gencode[codon]

with open("translate.out","w") as f:
    f.write( "sequence: {:s}\n".format(seq_prot) )
    f.write( "longueur prot: {:d} aa\n".format(len(seq_prot)) )
    f.write( "composition: {:s}\n".format(get_compo(seq_prot)) )
