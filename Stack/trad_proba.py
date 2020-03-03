#version du 06022019 by JR
import xml.etree.ElementTree as ET
import sys
import re
from py_translator import TEXTLIB
from itertools import groupby

file = open("outscript.txt","w") 

print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))

if len(sys.argv)<2:
    print("------------------------ Met un nom de fichier en argument !!!!!!!!!!!!!!!!!!!!!!!")
    exit(0)
tree = ET.parse(sys.argv[1])
root = tree.getroot()

def decomp_phrase_pour_trad(src):
    #on regarde s'il n'y a pas de simple crochet maxima {@(.*?)@} qui trainent
    isParthese = re.split(r'\\\((.*?)\\\)',src,flags=re.DOTALL|re.MULTILINE)
    isBra = re.split(r'\\\[(.*?)\\\]',src,flags=re.DOTALL|re.MULTILINE)
    isParthese = [x for x in isParthese if x is not None]
    #on parcourt les indices pairs, si on trouve un {@ @} alors on ajoute des balises maths
    for ii in range(len(isParthese)):
        if ii % 2 ==0:
            for jj in range(len(isBra)):
                if isParthese[ii] in isBra[jj] and jj%2==0:
                    isParthese[ii]=re.sub('{@','\({@',isParthese[ii])
                    isParthese[ii]=re.sub('@}','@}\)',isParthese[ii])
        else:
            isParthese[ii]='\('+isParthese[ii]+'\)'
    src = ' '.join(isParthese)

    #on traite les expression maths latex qui ne doivent pas etre traduite
    bratype = re.findall(r'\\\((.*?)\\\)|\\\[(.*?)\\\]|<code>(.*?)</code>|<table>(.*?)</table>|<table cellpadding="6">(.*?)</table>|<table style="padding-bottom:1em">(.*?)</table>',src,flags=re.DOTALL|re.MULTILINE)
    totreat = re.split(r'\\\((.*?)\\\)|\\\[(.*?)\\\]|<code>(.*?)</code>|<table>(.*?)</table>|<table cellpadding="6">(.*?)</table>|<table style="padding-bottom:1em">(.*?)</table>',src,flags=re.DOTALL|re.MULTILINE)
    totreat = [x for x in totreat if x is not None]
    treated=[]
    for inds in range(len(totreat)):
        s=totreat[inds]
        epmath=0
        ephtml=0
        if s!='':
            for tup in bratype:
                if s in tup:
                    if tup.index(s)==0:
                        #on a des parenthese
                        treated.append('\\('+s+'\\)')
                        epmath=1
                        break
                    elif tup.index(s)==1:
                        #on a des crochets
                        treated.append('\\['+s+'\\]')
                        epmath=1
                        break
                    elif tup.index(s)==2:
                        #on a balise <code>
                        treated.append('<code>'+s+'</code>')
                        ephtml=1
                        break
                    elif tup.index(s)==3:
                        #on a balise <table>
                        treated.append('<table>'+s+'</table>')
                        ephtml=1
                        break
                    elif tup.index(s)==4:
                        #on a balise <table>
                        treated.append('<table cellpadding="6">'+s+'</table>')
                        ephtml=1
                        break
                    elif tup.index(s)==5:
                        #on a balise <table>
                        treated.append('<table style="padding-bottom:1em">'+s+'</table>')
                        ephtml=1
                        break

            if epmath==0 and ephtml==0: # on pas d'expr latex ou html mais du texte
                treated.append(TEXTLIB().translator(is_html=False,text=s,lang_to='fr',proxy=False))

    treated = ' '.join(treated)
    #quand GG tranduit <strong> text </strong> il ajoute un espace : </ strong>
    treated = re.sub('/ strong','/strong',treated)
    treated = re.sub('/ Strong','/strong',treated)
    treated = re.sub('< Strong','<strong',treated)
    treated = re.sub('<Strong','<strong',treated)
    treated = re.sub('/ div','/div',treated)
    treated = re.sub('/ p','/p',treated)
    treated = re.sub('/ b','/b',treated)
    treated = re.sub('/ em','/em',treated)
    treated = re.sub('/ i','/i',treated)
    return treated

def build_fr_phrase(src):


    src = re.sub('&nbsp;',' ',src,flags=re.DOTALL|re.MULTILINE)
    aux = re.split('<div style="font-weight:bold">(.*?)</div>',src,flags=re.DOTALL|re.MULTILINE)
    src = ''.join(aux)

    src = re.sub('<span class="multilang" lang="(FI|fi)">(.*?)</span>', '',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('<span class="multilang" lang="(SV|sv)">(.*?)</span>', '',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('<span lang="(FI|fi)" class="multilang">(.*?)</span>', '',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('<span lang="(SV|sv)" class="multilang">(.*?)</span>', '',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('<span class="multilang" lang="(EN|en)">', '<span lang="EN" class="multilang">',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('<span lang="en" class="multilang">','<span lang="EN" class="multilang">',src,flags=re.DOTALL|re.MULTILINE)
    src = re.sub('&nbsp;',' ',src,flags=re.DOTALL|re.MULTILINE)

    ph_tout = re.split('<span lang="EN" class="multilang">(.*?)</span>',src,flags=re.DOTALL|re.MULTILINE)
    ph_atrad = re.findall('<span lang="EN" class="multilang">(.*?)</span>',src,flags=re.DOTALL|re.MULTILINE)
#    if not 'lang="EN"' in src and not '\\[\\[' in ph_tout:
#        print(ph_tout)
#        ph_atrad=ph_tout

    newsp=[]
    for m in range(len(ph_tout)):
        if not ph_tout[m] in ph_atrad:
            newm=ph_tout[m]
        else:
        #on a trouve une phrase a traduire mais il faut enlever les \( et \)
            ph_tout[m] = ph_tout[m].replace("<i>", "")
            ph_tout[m] = ph_tout[m].replace("</i>", "")
            ph_tout[m] = ph_tout[m].replace("<p>", "")
            ph_tout[m] = ph_tout[m].replace("</p>", "")
            ph_tout[m] = ph_tout[m].replace("<b>", "")
            ph_tout[m] = ph_tout[m].replace("</b>", "")
            ph_tout[m] = ph_tout[m].replace("<br>", "")
            ph_tout[m] = ph_tout[m].replace("</br>", "")
            resfr = decomp_phrase_pour_trad(ph_tout[m])

            newm = '<span lang="EN" class="multilang">'+str(ph_tout[m])+'</span>'+'<span lang="FR" class="multilang">'+str(resfr)+'</span>'
        newsp.append(newm)
            
    phrasefr = ''.join(newsp)
    return phrasefr

for ch1 in root.iter():
    ctag=ch1.tag
    if "feedback" in ctag or ctag=="questiontext" or ctag=="prtcorrect" or ctag=="prtincorrect" or ctag=="prtpartiallycorrect":
        for ch2 in ch1.iter():
            if ch2.tag=="text" and not (ch2.text is None):
#                if "The vertices of a triangle are located" in ch2.text:
#                if "Kompleksiluku kirjoitetaan esimerkiksi muodossa" in ch2.text:
#                if "Denote the vertices of the triangle as vectors" in ch2.text:
#                if "hakasulkeiden avulla alkiot pilkulla erotettuina." in ch2.text:
                    file.write(ch2.text+'\n')
                    phrasefr = build_fr_phrase(ch2.text)
                    file.write('..........................................\n')
                    file.write(phrasefr+'\n')
                    ch2.text = phrasefr
                    file.write('---------------------------------------------------------------------\n')
#    if "category" in ctag:
#        for ch2 in ch1.iter():
#            ch2.text=TEXTLIB().translator(is_html=False,text=ch2.text,lang_to='fr',proxy=False)
            
tree.write(sys.argv[1][0:-4]+'-fr2.xml')

