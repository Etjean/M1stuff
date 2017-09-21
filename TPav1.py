#import time

#taille = 50000000
## methode 1
## methode plus rapide car python n'as pas a créer un liste, puis la parcourir.
#start = time.time()
#for i in range(taille):
#    a = i
#print("methode 1 (for in range) : %.1f secondes" %( time.time() - start ))
## methode 2
#start = time.time()
#for i in list(range(taille)):
#    a = i
#print("methode 2 (for in list(range)) : %.1f secondes" %( time.time() - start ))


###################################################################################


#import time

## création d'une liste de 5 000 000 d'éléments
## (à adapter suivant vos machines)
#taille = 20000000
#print("Création d'une liste avec %d élements" %( taille ))
#toto = range( taille )

## la variable 'a' accède à un élément de la liste

## méthode 1
#start = time.time()
#for i in range( len(toto) ):
#    a = toto[i]
#print("méthode 1 (for in range) : %.1f secondes" %( time.time() - start ))

## méthode 2
#start = time.time()
#for i in list(range( len(toto) )):
#    a = toto[i]
#print("méthode 2 (for in list(range)) : %.1f secondes" %( time.time() - start ))

## méthode 3
#start = time.time()
#for ele in toto:
#    a = ele
#print("méthode 3 (for in) : %.1f secondes" %( time.time() - start ))

## méthode 4
#start = time.time()
#for idx, ele in enumerate( toto ):
#    a = ele
#print("méthode 4 (for in enumerate): %.1f secondes" %( time.time() - start ))

##La méthode 4 donne à la fois les indices et les éléments.
##Il faut éviter d'utiliser len(range()) et list(len(range()))


###########################################################################################


## jeu sur la casse des mots d'une phrase
#message = "C'est sympa la BioInfo"
#msg_lst = message.split()
#print([[m.upper(), m.lower(), len(m)] for m in msg_lst])


##########################################################################################


#noprimes = [j for i in range(2, 8) for j in range(i*2, 50, i)]
#primes = [x for x in range(2, 50) if x not in noprimes]
#print(noprimes)
#print(primes)


##########################################################################################


#import urllib.request

#data = urllib.request.urlopen("http://www.rcsb.org/pdb/files/1AHO.pdb")
#page = data.read()
#print(page)


##########################################################################################


#import urllib.request

#def download_page(address):
#    error = ""
#    page = ""
#    try:
#        data = urllib.request.urlopen(address)
#        page = data.read()
#    except IOError as e:
#        if hasattr(e, 'reason'):
#            error =  "Cannot reach web server: " + str(e.reason)
#        if hasattr(e, 'code'):
#            error = "Server failed {:d}".format(e.code)
#    return page, error

##programme principal
#data, error = download_page("http://www.uniprot.org/uniprot/P11540.fasta")
#if error:
#    print("Erreur rencontrée : {}".format(error))
#else:
#    with open("P11540.fasta", "w") as prot:
#        prot.write(data.decode('utf-8'))
#    print("Protéine enregistrée")


##########################################################################################


# importation du module
from Bio import Entrez

# quand on fait une requête sur les serveurs du NCBI, il faut indiquer son adresse e-mail
Entrez.email = "etienne_jean5@hotmail.fr"

## lancement de la requête
#req_esearch = Entrez.esearch(retmax=50, db="pubmed", term="barstar")

## lecture de la requête
#res_esearch = Entrez.read(req_esearch)

#print(res_esearch.keys())
##dict_keys(['QueryTranslation', 'IdList', 'RetMax', 'TranslationStack', 'TranslationSet', 'Count', 'RetStart'])
#print(res_esearch['IdList'])
#print(len(res_esearch['IdList'])) #seulement 20 PMID
#print(res_esearch['Count']) #Il y a 324 PMID en tout


##########################################################################################


# le module biopython est déjà chargé
# et la variable Entrez.email correctement configurée

## lancement de la requête
#req_esummary = Entrez.esummary(db="pubmed", id='27902436')

## lecture de la requete
#res_esummary = Entrez.read(req_esummary)

#print(len(res_esummary))
#print(res_esummary[0].keys())
#print(res_esummary[0]['Title'])
#print(res_esummary[0]['DOI'])
#print(res_esummary[0]['Source'])
#print(res_esummary[0]['PubDate'])


##########################################################################################


# le module biopython est déjà chargé
# et la variable Entrez.email correctement configurée

## lancement de la requête
#req_efetch = Entrez.efetch(db="pubmed", id='27902436', rettype="txt")

## lecture de la requete
#res_efetch = Entrez.read(req_efetch)

#resume = res_efetch['PubmedArticle'][0]['MedlineCitation']['Article']['Abstract']['AbstractText'][0]

#print(resume)
#print(str(len(resume))+' caractères dans ce résumé.')


##########################################################################################


## lancement de la requête
#req_esearch = Entrez.esearch(retmax=10000, db="pubmed", term="barstar")

## lecture de la requête
#res_esearch = Entrez.read(req_esearch)


##dict_keys(['QueryTranslation', 'IdList', 'RetMax', 'TranslationStack', 'TranslationSet', 'Count', 'RetStart'])
#pmids = res_esearch['IdList']
#print(len(pmids))

#years = []
#dates = []
#for i, pmid in enumerate(pmids):
#    # lancement de la requête
#    req_esummary = Entrez.esummary(db="pubmed", id=pmid)
#    # lecture de la requête
#    res_esummary = Entrez.read(req_esummary)
#    date = res_esummary[0]['PubDate']
#    dates.append(date)
#    year = int(date.split()[0])
#    years.append(year)
#    print('récupération des dates en cours : {}/324'.format(i+1))
#print(years)
#print(dates)


##########################################################################################



#years = [2017, 2017, 2017, 2017, 2017, 2017, 2017, 2016, 2016, 2016, 2016, 2016, 2015, 2015, 2016, 2016, 2015, 2016, 2015, 2016, 2015, 2015, 2015, 2015, 2015, 2015, 2014, 2015, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2013, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2012, 2011, 2012, 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2010, 2010, 2010, 2010, 2010, 2010, 2010, 2010, 2010, 2010, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2009, 2008, 2008, 2009, 2008, 2008, 2008, 2008, 2008, 2008, 2008, 2008, 2008, 2008, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2007, 2006, 2007, 2006, 2006, 2006, 2006, 2007, 2007, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2006, 2005, 2006, 2005, 2006, 2005, 2005, 2005, 2005, 2005, 2005, 2004, 2004, 2004, 2005, 2004, 2004, 2004, 2004, 2004, 2004, 2004, 2003, 2004, 2003, 2003, 2003, 2003, 2003, 2003, 2003, 2003, 2003, 2003, 2003, 2002, 2002, 2001, 2002, 2002, 2002, 2002, 2002, 2002, 2002, 2002, 2002, 2002, 2002, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2001, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 1999, 2000, 2000, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1998, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1997, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1995, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1994, 1993, 1993, 1993, 1993, 1993, 1993, 1993, 1993, 1992, 1989, 1988, 1977, 1973, 1972, 1972]
#dates = ['2017 Aug 30', '2017 Aug 8', '2017 Jul 21', '2017 Jul 13', '2017 Feb', '2017 Mar 2', '2017 Feb', '2016 Dec 1', '2016 Nov 16', '2016 Jun 14', '2016 Aug 15', '2016 May', '2015 Sep-Oct', '2015 Sep-Oct', '2016 Feb 1', '2016 Jan 14', '2015 Dec', '2016 Jan 29', '2015 Nov 15', '2016 Aug', '2015 Aug 20', '2015 Sep', '2015 Jun 28', '2015 Feb 7', '2015 Feb 19', '2015 Jan 6', '2014 Oct', '2015 Jan 29', '2014 Oct', '2014 Aug', '2014 Aug 12', '2014 Nov', '2014', '2014 Jun', '2014 Jan 15', '2013 Dec 21', '2013 Nov 19', '2013 Aug 13', '2013 Sep-Oct', '2013 Jul', '2013 May 14', '2013 May 23', '2013 May 16', '2013', '2013 Jun', '2013 Mar 12', '2013 May', '2013 Feb 26', '2013 Jan 29', '2013 Jan 8', '2012 Dec 7', '2012 Dec 5', '2012', '2012 Nov 14', '2012 Nov 28', '2012', '2012 Nov', '2012 Aug 22', '2012 Sep', '2012 Oct', '2012 Jun 7', '2012 Aug', '2012 Jun 15', '2012 May', '2012 Mar 13', '2012', '2011 Sep-Oct', '2012 Jan 14', '2011 Sep', '2011 Oct', '2011 Oct', '2011 Jun 9', '2011 Mar 29', '2011 Feb 2', '2011 Feb 8', '2011 Jan 25', '2010 Dec 2', '2010 Nov 3', '2010 Nov-Dec', '2010 Nov 10', '2010 Sep 7', '2010 Sep 10', '2010 Nov', '2010 Mar 30', '2010 Jun', '2010 Jul', '2009 Nov-Dec', '2009 Sep 16', '2009 Sep 2', '2009 Oct 30', '2009', '2009 Aug 5', '2009 Sep', '2009 Jul 8', '2009 Jul 14', '2009 Apr 21', '2009 Jan 20', '2009 Jan 30', '2009 Jan 14', '2008 Oct 21', '2008 Aug 21', '2009 Jan', '2008 Oct 14', '2008 Oct', '2008 Oct 24', '2008 Oct', '2008 Jun 10', '2008 Jun', '2008 Apr', '2008 May 15', '2008 Mar 21', '2008 Feb 15', '2007 Dec 28', '2007 Sep', '2007 Oct', '2007 Jul 7', '2007 Aug 9', '2007 Aug 3', '2007 Jun 8', '2007 Jul 6', '2007 Apr 10', '2007 Mar 14', '2007 Jun 10', '2007 Jan-Feb', '2007 Apr 6', '2007 Apr 6', '2007 Jun', '2007 Feb 23', '2006 Nov-Dec', '2007 Mar 1', '2006', '2006 Oct 18', '2006 Oct', '2006 Nov 17', '2007 Jan', '2007 Jan', '2006 Aug', '2006 Dec', '2006 Oct 1', '2006 Oct', '2006 Nov 10', '2006 Jul', '2006 Jun', '2006 Mar-Apr', '2006 May 26', '2006 May 12', '2006 Apr', '2005 Apr-Jun', '2006 Mar 15', '2005 Dec 13', '2006 Jan 17', '2005 Oct 19', '2005 Oct 28', '2005 Sep 15', '2005 Jul', '2005 Jul 21', '2005 Jan 31', '2004 Nov-Dec', '2004 Dec', '2004 Sep', '2005 Jan 1', '2004 Sep 14', '2004 Sep', '2004 Jul', '2004 Sep 24', '2004 May 28', '2004 May 1', '2004 Mar 26', '2003 Nov-Dec', '2004 Jan 16', '2003 Dec', '2003 Sep-Oct', '2003 Sep', '2003 Oct', '2003 Aug 21', '2003 Dec', '2003 Jul 8', '2003 Jul', '2003 Feb 18', '2003 Jan 1', '2003 Jan 1', '2002 Dec', '2002 Nov 22', '2001', '2002 Nov', '2002 Nov 4', '2002 Jul-Aug', '2002 Aug 6', '2002 Jun', '2002 Apr 19', '2002 Apr', '2002 Feb 12', '2002 Feb 5', '2002 Feb', '2002 Feb', '2001 Oct', '2001 Dec 18', '2001 Nov 28', '2001', '2001 Oct', '2001 Sep', '2001 Mar 7', '2001 Jul', '2001 Jun 15', '2001 Mar', '2001 Apr 20', '2001 Feb', '2001', '2001 Mar 2', '2001 Mar 9', '2001 Feb 5', '2001 Feb', '2001 Jan', '2000 Oct', '2000 Nov 21', '2000 Dec 1', '2000 Sep', '2000 Nov 15', '2000 Dec', '2000 Sep 15', '2000 Jun 1', '2000 May', '2000 Apr', '2000 Apr 14', '1999 Jun-Aug', '2000 Mar 31', '2000 Mar', '1999 Sep', '1999 May-Jun', '1999 Jul-Aug', '1999 Jul', '1999 Jul 13', '1999 Jun', '1999 Jun 11', '1999 Jun', '1999', '1999 Feb 26', '1999 Feb', '1999 Mar 26', '1999 Mar 12', '1999 Mar', '1999 Jan 22', '1998 Sep', '1998 Jun', '1998 Jun', '1998 Oct 7', '1998 Oct 13', '1998 May 1', '1998 Sep 1', '1998 Sep 1', '1998 Aug 11', '1998 May 22', '1998 May 12', '1998 Mar', '1998 Feb 15', '1998 Mar', '1998 Feb', '1997 Dec', '1997 Dec', '1997 Nov 1', '1997 Sep', '1997 Oct', '1997 Oct 7', '1997 Aug 12', '1997 Jul 15', '1997 Jul 4', '1997 Jun 6', '1997 Jun', '1997 May 2', '1997 May', '1997 May', '1997 Apr 11', '1997 Apr 4', '1997 Feb 4', '1997', '1996 Nov', '1996 Oct 1', '1996 Sep-Oct', '1996 Jul 22', '1996 Jul 16', '1996 Jul 2', '1996 Jun 21', '1996 May', '1996 Mar 19', '1996 Feb 22', '1995 Nov 7', '1995 Oct 26', '1995 Aug 21', '1995 Aug', '1995 Jun 12', '1995 Jun', '1995 May', '1995 Apr 28', '1995 Apr 18', '1995 Apr 14', '1995 Mar 14', '1995 Feb 7', '1994 Dec', '1994 Nov 14', '1994 Nov', '1994 Oct 28', '1994 Oct 15', '1994 Sep', '1994 Aug 2', '1994 Aug 2', '1994 May 16', '1994 Mar 29', '1994 Mar-Apr', '1994 Jan 11', '1993 Nov 15', '1993 Nov', '1993 Oct 19', '1993 Oct 11', '1993 Sep 27', '1993 Jun 15', '1993 Jun', '1993 May 18', '1992', '1989 Nov', '1988 Aug 20', '1977 May 25', '1973 Aug 25', '1972', '1972']

#freq = {}
#for year in years:
#    if year not in freq:
#        freq[year] = 1
#    else:
#        freq[year] += 1

#x = list(freq.keys())
#x.sort()
#y = [freq[i] for i in x]
#print('première apparition de la barstar : {}'.format(x[0]))


#import matplotlib.pyplot as plt
#plt.bar(x, y)
#plt.show()

#import matplotlib.pyplot as plt
#plt.bar(x, y)

## redéfinition des valeurs sur l'axe des ordonnées
#plt.yticks(list(range(0, max(y), 2)))

## étiquetage des axes et du graphique
#plt.xlabel("Années")
#plt.ylabel("Nombre de publications")
#plt.title("Distribution des publications qui mentionnent la barstar")

## enregistrement sur le disque
#plt.savefig('distribution_barstar_annee.png', bbox_inches='tight', dpi=200)


##########################################################################################

import numpy as np
# info perso : la barstar a 89 acides aminés

with open('1BTA_CA.txt', 'r') as filin:
    line = filin.readline()
    coords = line.split()
    xyzs = []
    for i in range(0, len(coords), 3):
        xyz = [float(coords[i]), float(coords[i+1]), float(coords[i+2])]
        xyzs.append(xyz)

xyzs = np.array(xyzs)
print(xyzs)
xyzs_premiers = np.array(xyzs[:len(xyzs)-1,:])
xyzs_derniers = np.array(xyzs[1:,:])


dists = np.sqrt(np.sum((xyzs_premiers - xyzs_derniers)**2, 1))
dists = list(dists)
print(dists)























