from bs4 import BeautifulSoup
import re

soup = BeautifulSoup(open("bp.php"))


class Link():
    def __init__(self, adres, tekst):
        self.adres = adres
        if tekst == None:
            tekst = re.sub("http://", "", adres)
        self.tekst = tekst
    def __repr__(self):
        return "<a href={0}>{1}</a>".format(self.adres, self.tekst)
    def __str__(self):
        return "{0}[{1}]".format(self.tekst, self.adres)

class Relacja_galeria(Link):
    def __init__(self, adres, autor="nieznany"):
        self.adres = adres
        self.tekst = autor

class Rajd:   
    def __init__(self, nazwa, rok, data="brak danych",
                 gdzie = "brak danych",
                 meta="brak danych",
                 organizatorzy=[],
                 galerie=[Relacja_galeria("","brak")],
                 relacje=[Relacja_galeria("","brak")],
                 informatorki=[Link("","brak")],
                 inne=""):
        self.nazwa = nazwa
        self.rok  =  rok
        self.data = data
        self.gdzie = gdzie
        self.meta = meta
        self.organizatorzy = organizatorzy
        self.galerie = galerie
        self.relacje = relacje
        self.informatorki = informatorki
        self.inne = inne


    def linki_na_ciag(self, linki):
        if linki == None:
            return ""
        ciag = str(linki[0])
        for link in linki[1:]:
            ciag = ciag + ", "+str(link)
        return ciag

    def __repr__(self):        
        organizatorzy = ", ".join(self.organizatorzy) if self.organizatorzy!=None else ""
        relacje = self.linki_na_ciag(self.relacje)
        galerie = self.linki_na_ciag(self.galerie)
        informatorki = self.linki_na_ciag(self.informatorki)
        format_string = "nazwa: {0}\nrok: {1}\ndata: {2}\ngory: {3}\nmeta: {4}\norganizatorzy: {5}\nrelacje: {6}\ngalerie: {7}\ninformatorek: {8}"
        result = format_string.format(self.nazwa, self.rok, self.data,
                                     self.gdzie, self.meta, organizatorzy,
                                     relacje, galerie, informatorki)
        return result

    def csv(self):        
        organizatorzy = ", ".join(self.organizatorzy) if self.organizatorzy!=None else ""
        relacje = self.linki_na_ciag(self.relacje)
        galerie = self.linki_na_ciag(self.galerie)
        informatorki = self.linki_na_ciag(self.informatorki)
        format_string = "{0}; {1}; {2}; {3}; {4}; {5}; {6}; {7}; {8}"
        return format_string.format(self.nazwa, self.rok, self.data,
                                     self.gdzie, self.meta, organizatorzy,
                                     relacje, galerie, informatorki)

def zapisz_do_csv(rajdy):

        file = open("result.csv", "w")
        file.write("nazwa;rok;data;gory;meta;organizatorzy;relacje;galerie;informatorek\n")
        for rok, rajdy_rok in rajdy.iteritems():
            for rajd in rajdy_rok:
                file.write(rajd.csv()+"\n")
        file.close()


def zgadnij_etykiete(ciag):

    wzory = {r"meta(:)* ":"meta",
            r"(galeria|zdjecia|zdjęcia)(: |:| )+":"galeria",
            r"(informatorek)(: |:| )+":"informatorek",
            r"(relacja)(: |:| )+":"relacja",
            r"organizator[A-z]*(: |:| )+":"organizatorzy"
            }
    for reg, etykieta in wzory.items():
        if re.match(reg, ciag):
            wartosc = re.sub(reg, "", ciag)
            return etykieta, wartosc
    return "inne", ciag

h_roczniki = soup.html.body.findAll("div", "rocznik", recursive=False)
rajdy = {}
for h_rocznik in h_roczniki:
    rok = int(h_rocznik.a['name'])
    #print rok
    rajdy[rok] = []
    for ul_rajdy_wid in h_rocznik.findAll("ul", "rajdy_widoczne", recursive=False):
        h_rajdy = ul_rajdy_wid.findAll("li", recursive=False)
        for h_rajd in h_rajdy:    
            nazwa = h_rajd.contents[0].string.strip()        
            #print u"\t"+nazwa
            h_rajd_ul = h_rajd.find("ul", "kwadrat")
            if h_rajd_ul != None:
                h_detale = h_rajd_ul.findAll("li")
                data = h_detale[0].string.strip()
                gdzie = h_detale[1].string.strip()
                detale = {}
                for i, detal in enumerate(h_detale[2:]):
                    #for subdetal in detal.contents:  
                         subdetal = detal.contents[0]                 
                         etykieta, wartosc = zgadnij_etykiete(subdetal.string.strip())
                         if etykieta in ("informatorek", "relacja", "galeria"):
                             detale[etykieta] = detale.setdefault(etykieta, [])
                             h_linki = detal.findAll("a")
                             if len(h_linki) == 0:
                                 link = Link("", wartosc)
                                 detale[etykieta].append(link)
                             else:
                                 for h_link in h_linki:
                                     adres = h_link["href"]
                                     tekst = h_link.string
                                     if etykieta == "informatorek":
                                         link = Link(adres, tekst)
                                     else:
                                         link = Relacja_galeria(adres, tekst)
                                     detale[etykieta].append(link)
                         elif etykieta == "inne":
                             detale[etykieta] = detale.setdefault(etykieta, [])
                             detale[etykieta].append(wartosc)
                         else:
                             detale[etykieta] = wartosc
                         #print etykieta+": "+wartosc                 
                         #print "\t\t"+subdetal.string
                         
                organizatorzy = detale.get("organizatorzy")
                if organizatorzy != None:
                    organizatorzy = organizatorzy.split(", ")

                rajd = Rajd(nazwa, rok, data, gdzie,
                            meta = detale.get("meta"),
                            organizatorzy = organizatorzy,
                            galerie = detale.get("galeria"),
                            relacje = detale.get("relacja"),
                            informatorki = detale.get("informatorek"),
                            inne = detale.get("inne"))
                rajdy[rok].append(rajd)

zapisz_do_csv(rajdy)

