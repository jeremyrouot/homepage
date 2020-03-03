function generate_cryptage_godot_translation
  clear
  
  function snum = translate_ascii(s,t)
    snum = double(s)+t;
  endfunction
  
  function news = inv_translate_ascii_fromfile(f,t)
    l1 = fileread(f)
    l1 = str2num (strcat (l1))';
    news=char(l1-t);
  endfunction
  
  
  inv_translate_ascii_fromfile("exdata.txt",3)
  
  aux="LUCKY (debit monotone) : Etant donne l'existence telle qu'elle jaillit des recents travaux publics de Poincon et Wattmann d'un Dieu personnel quaquaquaqua a barbe blanche quaqua hors du temps de l'etendue qui du haut de sa divine apathie sa divine athambie sa divine aphasie nous aime bien a quelques exceptions pres on ne sait pourquoi mais ca viendra et souffre a l'instar de la divine Miranda avec ceux qui sont on ne sait pourquoi mais on a le temps dans le tourment dans les feux dont les feux les flammes pour peu que ca dure encore un peu et qui peut en douter mettront a la fin le feu aux poutres assavoir porteront l'enfer aux nues si bleues par moments encore aujourd'hui et calmes si calmes d'un calme qui pour etre intermittent n'en est pas moins le bienvenu mais n'anticipons pas et attendu d'autre part qu'a la suite des recherches inachevees n'anticipons pas des recherches inachevees mais neanmoins couronnees par l'Acacacacademie d'Anthropopopometrie de Berne-en-Bresse de Testu et Conard il est etabli sans autre possibilite d'erreur que celle afferente aux calculs humains qu'a la suite des recherches inachevees inachevees de Testu et Conard il est etabli tabli tabli ce qui suit qui suit qui suit assavoir mais n'anticipons pas on ne sait pourquoi a la suite des travaux de Poincon et Wattmann il apparait aussi clairement si clairement qu'en vue des labeurs de Fartov et Belcher inacheves inacheves on ne sait pourquoi de Testu et Conard inacheves inacheves il apparait que l'homme contrairement a l'opinion contraire que l'homme en Bresse de Testu et Conard que l'homme enfin bref que l'homme en bref enfin malgre les progres de l'alimentation et de l'elimination des dechets est en train de maigrir et en meme temps parallelement on ne sait pourquoi malgre l'essor de la culture physique de la pratique des sports tels tels tels le tennis le football la course et a pied et a bicyclette la natation l'equitation l'aviation la conation le tennis le camogie le patinage et sur glace et sur asphalte le tennis l'aviation les sports les sports d'hiver d'ete d'automne d'automne le tennis sur gazon sur sapin et sur terre battue l'aviation le tennis le hockey sur terre sur mer et dans les airs la penicilline et succedanes bref je reprends en meme temps parallelement de rapetisser on ne sait pourquoi malgre le tennis je reprends l'aviation le golf tant a neuf qu'a dix-huit trous le tennis sur glace bref on ne sait pourquoi en Seine Seine-et-Oise Seine-et-Marne Marne-et-Oise assavoir en meme temps parallelement on ne sait pourquoi de maigrir retrecir je reprends Oise Marne bref la perte seche par tete de pipe depuis la mort de Voltaire etant de l'ordre de deux doigts cent grammes par tete de pipe environ en moyenne a peu pres chiffres ronds bon poids deshabille en Normandie on ne sait pourquoi bref enfin peu importe les faits sont la et considerant d'autre part ce qui est encore plus grave qu'il ressort ce qui est encore plus grave qu'a la lumiere la lumiere des experiences en cours de Steinweg et Petermann il ressort ce qui est encore plus grave qu'il ressort ce qui est encore plus grave a la lumiere la lumiere des experiences abandonnees de Steinweg et Petermann qu'a la campagne a la montagne et au bord de la mer et des cours et d'eau et de feu l'air est le meme et la terre assavoir l'air et la terre par les grands froids l'air et la terre faits pour les pierres et les grands froids helas au septieme de leur ere l'ether la terre la mer pour les pierres par les grands fonds les grands froids sur mer sur terre et dans les airs peuchere je reprends on ne sait pourquoi malgre le tennis les faits sont la on ne sait pourquoi je reprends au suivant bref enfin helas au suivant pour les pierres qui peut en douter je reprends mais n'anticipons pas je reprends la tete en meme temps parallelement on ne sait pourquoi malgre le tennis au suivant la barbe les flammes les pleurs les pierres si bleues si calmes helas la tete la tete la tete la tete en Normandie malgre le tennis les labeurs abandonnes inacheves plus grave les pierres bref je reprends helas helas abandonnes inacheves la tete la tete en Normandie malgre le tennis la tete helas les pierres Conard Conard... (Melee. Lucky pousse encore quelques vociferations.) Tennis !... Les pierres !... Si calmes !... Conard !... Inacheves !...  .  .  .  tennis";
  entry = 0;
  %{
  fileID = fopen("sol-godot-cryptage.txt","w");   
  for pos=40:7:length(aux)-40;
    entry = entry+1;
    Nok=1000000 + randi(1000000);     
    src = strcat(aux(1:pos),"Solutio est "," ",num2str(Nok),aux(pos+1:end));
    
    M = max(double(src));
    t = randi(max(1,127-M));
    h1 = translate_ascii(src,t)';
    nam=(277*entry)^2+entry + 282;
    filename = ["text_crypt/tirade_lucky",num2str(nam),".txt"];
    fid = fopen (filename, "w");
    csvwrite(filename,h1);
    fclose (fid);
    
    d1 = inv_translate_ascii_fromfile(filename,t);
    
    fprintf(fileID,"footable[%i]:[%i,%i,%i];\n",entry,t,Nok,nam);
    
  endfor
    fclose(fileID);
  %}


  endfunction