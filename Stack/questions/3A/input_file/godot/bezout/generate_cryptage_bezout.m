function generate_cryptage_bezout
  clear
  
  %% ON POURRAIT AUSSI DEMANDER DE RENVOYER LA SOMME DE TOUS LES CARACTERES 
  % ASCII DECRYPTES
  
  function res = xgcd(a,b)
    aold = a;
    bold = b;
    aa=[1,0];
    bb=[0,1]; 
    res = [0,0,0];
    while(1) 
    q = floor(a / b); 
    a = mod(a,b);
    aa(1) = aa(1) - q*aa(2);  bb(1) = bb(1) - q*bb(2);
    if (a == 0) 
      res(1) = b; 
      res(2) = aa(2); 
      res(3) = bb(2);
      return;
    endif
    q = floor(b / a); 
    b = mod(b,a);
    aa(2) = aa(2) - q*aa(1);  bb(2) = bb(2) - q*bb(1);
    if (b == 0) 
      res(1) = a; 
      res(2) = aa(1); 
      res(3) = bb(1);
      return;
    endif
  endwhile
endfunction

function mc = crypte(mot,p)
  s = double(mot);
  mc = [];
  for i=1:length(s)
    a=s(i);
    % on crypte
    aux = xgcd(a,p);
    c = mod(aux(2),p);
    mc = [mc(:); c]';
  endfor
endfunction


function motclear = decrypte(f,p)
  l1 = fileread(f);
  l1 = str2num (strcat (l1))';
  motclear = "";
  for im=1:length(l1)
    mot=l1(im);
    for i=1:length(mot)
      %on trouve le coeff de bezout associe
      r = xgcd(mot(i),p);
      cclear = char(mod(r(2),p));
      motclear = cstrcat(motclear,cclear); 
    endfor
  endfor
endfunction

lp = [257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 ...
359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 ...
467 479 487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593 599 ...
601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719 ...
727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 ...
857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 ...
991 997];
nbp = numel(lp);



ltext= {"LUCKY (debit monotone) : Etant donne l'existence telle qu'elle jaillit des recents travaux publics de Poincon et Wattmann d'un Dieu personnel quaquaquaqua a barbe blanche quaqua hors du temps de l'etendue qui du haut de sa divine apathie sa divine athambie sa divine aphasie nous aime bien a quelques exceptions pres on ne sait pourquoi mais ca viendra et souffre a l'instar de la divine Miranda avec ceux qui sont on ne sait pourquoi mais on a le temps dans le tourment dans les feux dont les feux les flammes pour peu que ca dure encore un peu et qui peut en douter mettront a la fin le feu aux poutres assavoir porteront l'enfer aux nues si bleues par moments encore aujourd'hui et calmes si calmes d'un calme qui pour etre intermittent n'en est pas moins le bienvenu mais n'anticipons pas et attendu d'autre part qu'a la suite des recherches inachevees n'anticipons pas des recherches inachevees mais neanmoins couronnees par l'Acacacacademie d'Anthropopopometrie de Berne-en-Bresse de Testu et Conard il est etabli sans autre possibilite d'erreur que celle afferente aux calculs humains qu'a la suite des recherches inachevees inachevees de Testu et Conard il est etabli tabli tabli ce qui suit qui suit qui suit assavoir mais n'anticipons pas on ne sait pourquoi a la suite des travaux de Poincon et Wattmann il apparait aussi clairement si clairement qu'en vue des labeurs de Fartov et Belcher inacheves inacheves on ne sait pourquoi de Testu et Conard inacheves inacheves il apparait que l'homme contrairement a l'opinion contraire que l'homme en Bresse de Testu et Conard que l'homme enfin bref que l'homme en bref enfin malgre les progres de l'alimentation et de l'elimination des dechets est en train de maigrir et en meme temps parallelement on ne sait pourquoi malgre l'essor de la culture physique de la pratique des sports tels tels tels le tennis le football la course et a pied et a bicyclette la natation l'equitation l'aviation la conation le tennis le camogie le patinage et sur glace et sur asphalte le tennis l'aviation les sports les sports d'hiver d'ete d'automne d'automne le tennis sur gazon sur sapin et sur terre battue l'aviation le tennis le hockey sur terre sur mer et dans les airs la penicilline et succedanes bref je reprends en meme temps parallelement de rapetisser on ne sait pourquoi malgre le tennis je reprends l'aviation le golf tant a neuf qu'a dix-huit trous le tennis sur glace bref on ne sait pourquoi en Seine Seine-et-Oise Seine-et-Marne Marne-et-Oise assavoir en meme temps parallelement on ne sait pourquoi de maigrir retrecir je reprends Oise Marne bref la perte seche par tete de pipe depuis la mort de Voltaire etant de l'ordre de deux doigts cent grammes par tete de pipe environ en moyenne a peu pres chiffres ronds bon poids deshabille en Normandie on ne sait pourquoi bref enfin peu importe les faits sont la et considerant d'autre part ce qui est encore plus grave qu'il ressort ce qui est encore plus grave qu'a la lumiere la lumiere des experiences en cours de Steinweg et Petermann il ressort ce qui est encore plus grave qu'il ressort ce qui est encore plus grave a la lumiere la lumiere des experiences abandonnees de Steinweg et Petermann qu'a la campagne a la montagne et au bord de la mer et des cours et d'eau et de feu l'air est le meme et la terre assavoir l'air et la terre par les grands froids l'air et la terre faits pour les pierres et les grands froids helas au septieme de leur ere l'ether la terre la mer pour les pierres par les grands fonds les grands froids sur mer sur terre et dans les airs peuchere je reprends on ne sait pourquoi malgre le tennis les faits sont la on ne sait pourquoi je reprends au suivant bref enfin helas au suivant pour les pierres qui peut en douter je reprends mais n'anticipons pas je reprends la tete en meme temps parallelement on ne sait pourquoi malgre le tennis au suivant la barbe les flammes les pleurs les pierres si bleues si calmes helas la tete la tete la tete la tete en Normandie malgre le tennis les labeurs abandonnes inacheves plus grave les pierres bref je reprends helas helas abandonnes inacheves la tete la tete en Normandie malgre le tennis la tete helas les pierres Conard Conard... (Melee. Lucky pousse encore quelques vociferations.) Tennis !... Les pierres !... Si calmes !... Conard !... Inacheves !...  .  .  .  tennis",...
"Mr. Sims...doesn't need to labeled: 'Still worthy of being a Baird Man'. What the hell is that? What is your motto here? Boys, inform on your classmates and save your hide; anything short of that we're gonna burn you at the stake? Well, gentlemen, when the shit hits the fan some guys run and some guys stay. Here's Charlie facing the fire; and there's George hidin' in big Daddy's pocket! And what are you doin'? You're gonna reward George and destroy Charlie. I don't know who went to this place, William Howard Taft, William Jennings Bryan, William Tell -- whoever. Their spirit is dead...if they ever had one. It's gone. You're building a rat ship here. A vessel for sea-goin' snitches. And if you think your preparing these minnows for manhood, you better think again, because I say you are killing the very spirit this institution proclaims it instills! What a sham. What kind of a show are you guys puttin' on here today. I mean, the only class in this act is sittin' next to me. And I'm here to tell ya this boy's soul is intact. It's non-negotiable. You know how I know? Someone here - and I'm not gonna say who - offered to buy it. Only Charlie here wasn't sellin'.",...
"I don't have to tell you things are bad. Everybody knows things are bad. It's a depression. Everybody's out of work or scared of losing their job. The dollar buys a nickel's worth, banks are going bust, shopkeepers keep a gun under the counter. Punks are running wild in the street and there's nobody anywhere who seems to know what to do, and there's no end to it. We know the air is unfit to breathe and our food is unfit to eat, and we sit watching our TVs while some local newscaster tells us that today we had fifteen homicides and sixty-three violent crimes, as if that's the way it's supposed to be. We know things are bad - worse than bad. They're crazy. It's like everything everywhere is going crazy, so we don't go out anymore. We sit in the house, and slowly the world we are living in is getting smaller, and all we say is: 'Please, at least leave us alone in our living rooms. Let me have my toaster and my TV and my steel-belted radials and I won't say anything. Just leave us alone.' Well, I'm not gonna leave you alone. I want you to get MAD! I don't want you to protest. I don't want you to riot - I don't want you to write to your congressman, because I wouldn't know what to tell you to write. I don't know what to do about the depression and the inflation and the Russians and the crime in the street. All I know is that first you've got to get mad. (shouting) You've got to say: 'I'm a human being, god-dammit! My life has value!' So, I want you to get up now. I want all of you to get up out of your chairs. I want you to get up right now and go to the window. Open it, and stick your head out, and yell: I'm as mad as hell, and I'm not gonna take this anymore!",...
"The question is, 'Do I have a 'God Complex'?...which makes me wonder if this lawyer has any idea as to the kind of grades one has to receive in college to be accepted at a top medical school. Or if you have the vaguest clue as to how talented someone has to be to lead a surgical team. I have an M.D. from Harvard. I am board certified in cardio-thoracic medicine and trauma surgery. I have been awarded citations from seven different medical boards in New England, and I am never, ever sick at sea. So I ask you: when someone goes into that chapel and they fall on their knees and they pray to God that their wife doesn't miscarry, or that their daughter doesn't bleed to death, or that their mother doesn't suffer acute neural trauma from post-operative shock, who do you think they're praying to? Now, you go ahead and read your Bible *Dennis*, and you go to your church, and with any luck you might win the annual raffle, but if you're looking for God, he was in operating room number two on November 17th, and he doesn't like to be second-guessed. You ask me if I have a God complex? Let me tell you something: I Am God",...
"Rehabilitated? Well, now, let me see. You know, I don't have any idea what that means. I know what you think it means, sonny. To me, it's just a made up word; a politician's word, so that young fellas like yourself can wear a suit and a tie and have a job. What do you really wanna know? Am I sorry for what I did? There's not a day goes by I don't feel regret. Not because I'm in here, or because you think I should. I look back on the way I was then, a young, stupid kid who committed that terrible crime. I wanna talk to him. I wanna try to talk some sense to him, tell him the way things are, but I can't. That kid's long gone and this old man is all that's left. I gotta live with that. Rehabilitated? It's just a bullshit word. So, you go on and stamp your form, sonny, and stop wasting my time, because to tell you the truth, I don't give a shit",...
"I am William Wallace! And I see a whole army of my countrymen here, in defiance of tyranny. You've come to fight as free men, and free men you are. What will you do with that freedom? Will you fight? Fight and you may die. Run and you'll live, at least a while. And dying in your beds many years from now, would you be willing to trade all the days from this day to that for one chance, just one chance to come back here and tell our enemies that they may take our lives, but they'll never take our freedom!",...
"I was warned not to come here. I was warned. They warned me: 'Don't stand behind that coffin.' But why should I heed such a warning, when a heartbeat is silent and a child lies dead? 'Don't stand behind this coffin.' That boy was as pure and as innocent as the driven snow. But I must stand here because I have not given you what you should have. Until we can walk abroad and recreate ourselves, until we can stroll along the streets like boulevards, congregate in parks free from fear, our families mingling, our children laughing, our hearts joined - until that day, we have no city. You can label me a failure until that day. The first and perhaps only great mayor was Greek. He was Pericles of Athens, and he lived some 2,500 years ago, and he said: 'All things good of this Earth flow into the City, because of the City's greatness.' Well, we were great once. Can we not be great again? Now, I put that question to James Bone, and there's only silence. Yet could not something pass from this sweet youth to me? Could he not empower me to find in myself the strength to have the knowledge to summon up the courage to accomplish this seemingly insurmountable task of making a city livable? Just livable. There was a palace that was a city. It was a palace! It was a palace, and it can be a palace again! A palace, in which there is no king or queen, or dukes or earls or princes, but subjects all. Subjects beholden to each other, to make a better place to live. Is that too much to ask? Are we asking too much for thisIs it beyond our reach? Because if it is, then we are nothing but sheep being herded to the final slaughterhouse! I will not go down, that way! I choose to fight back! I choose to rise, not fall! I choose to live, not die! And I know, I know that what's within me is also within you. That's why I ask you now to join me. Join me, rise up with me, rise up on the wings of this slain angel. We'll rebuild on the soul of this little warrior. We will pick up his standard and raise it high! Carry it forward until this city - your city - our city - his city - is a palace of God! Is a palace of God! I am with you, little James. I am you",...
"I was Sheriff of this county when I was 25 years old. Hard to believe. My grandfather was a lawman, father too. Me and him was sheriffs at the same time, him up in Plano and me out here. I think he's pretty proud of that. I know I was. Some of the old time Sheriffs never even wore a gun. A lotta folks find that hard to believe. Jim Scarborough'd never carry one - that's the younger Jim. Gaston Borkins wouldn't wear one up in Comanche County. I always liked to hear about the old-timers. Never missed a chance to do so. You can't help but compare yourself against the old-timers. Can't help but wonder how they'd have operated in these times. There was this boy I sent to the 'lectric chair at Huntsville here awhile back. My arrest and my testimony. He killed a 14 year-old girl. Papers said it was a crime of passion, but he told me there wasn't any passion to it. Told me that he'd been plannin' to kill somebody for about as long as he could remember. Said that if they turned him out, he'd do it again. Said he knew he was going to hell: 'Be there in about fifteen minutes.' I don't know what to make of that. I surely don't. The crime you see now, it's hard to even take its measure. It's not that I'm afraid of it. I always knew you had to be willin' to die to even do this job. But, I don't want to push my chips forward and go out and meet somethin' I don't understand. A man would have to put his soul at hazard. He'd have to say: 'OK., I'll be a part of this world",...
"It's sad when a mother has to speak the words that condemn her own son, but I couldn't allow them to believe that I would commit murder. They'll put him away now, as I should have, years ago. He was always bad and in the end, he intended to tell them I killed those girls and that man. As if I could do anything except just sit and stare, like one of his stuffed birds. Oh, they know I can't even move a finger and I won't. I'll just sit here and be quiet, just in case they do suspect me. They're probably watching me. Well, let them. Let them see what kind of a person I am. I'm not even gonna swat that fly. I hope they are watching. They'll see. They'll see and they'll know and they'll say, 'Why, she wouldn't even harm a fly",...
"I'm sorry, but I don't want to be an emperor. That's not my business. I don't want to rule or conquer anyone. I should like to help everyone - if possible - Jew, Gentile - black man - white. We all want to help one another. Human beings are like that. We want to live by each other's happiness - not by each other's misery. We don't want to hate and despise one another. In this world there is room for everyone. And the good earth is rich and can provide for everyone. The way of life can be free and beautiful, but we have lost the way.Greed has poisoned men's souls, has barricaded the world with hate, has goose-stepped us into misery and bloodshed. We have developed speed, but we have shut ourselves in. Machinery that gives abundance has left us in want. Our knowledge has made us cynical. Our cleverness, hard and unkind. We think too much and feel too little. More than machinery we need humanity. More than cleverness we need kindness and gentleness. Without these qualities, life will be violent and all will be lost....The aeroplane and the radio have brought us closer together. The very nature of these inventions cries out for the goodness in men - cries out for universal brotherhood - for the unity of us all. Even now my voice is reaching millions throughout the world - millions of despairing men, women, and little children - victims of a system that makes men torture and imprison innocent people.",...
"The Fight: What does it mean and where does it come from? An Essay: Homosapien. A man. He is alone in the universe. A punker. Still a man. He is alone in the universe, but he connects. How? They hit each other. Ooh! No clearer way to evaluate whether or not you're alive. Now, complications. A reason to fight. Somebody different. Difference creates dispute. Dispute is a reason to fight. To fight is a reason to feel pain. Life is pain. So to fight with reason is to be alive with reason. Final analysis: To fight, a reason to live. Problems and Contradictions: I am an anarchist. I believe that there should be no rules, only chaos. Fighting appears to be chaos and when we slam in the pit a show it is. But when we fight for a reason, like rednecks, there's a system. We fight for what we stand for, chaos, but fighting is a structure, to establish power, power is government and government is not anarchy. Government is war and war is fighting. The circle goes like this: our redneck skirmishes are cheap perversions of conventional warfare. War implies extreme government because wars are fought to enforce rules or ideals, even freedom. But other people's ideals forced on someone else, even if it is something like freedom, is still a rule; not anarchy. This contradiction was becoming clear to me in the fall of '85. Even as early as my first party, 'Why did I love to fight?' I framed it, but still, I don't understand it. It goes against my beliefs as a true anarchist. But there it was. Competition, fighting, capitalism, government, THE SYSTEM. That's what we did. It's what we always did. Rednecks kicked the shit out of punks, punks kicked the shit out of mods, mods kicked the shit out of skinheads, skinheads took out the heavy metal guys, and the heavy metal guys beat the living shit out of new wavers and the new wavers didn't do anything. They were the new hippies. So what was the point? Final summation? None.",...
"Catholic Priest: I never thought I'd see the day: military courts established in Ireland by Irishmen; deportation or the death penalty for those caught with arms. In the name of God, what is going on? I found this on the street during the week: Under the Republic, the lands of the Aristocracy who live in luxury in London will be seized and divided up against landless workers and small farmers. All industry and agriculture will be controlled by the State for the workers' and famers' benefit. Not content with stealing your savings, they'll be nationalizing the 12 Apostles next. My dear brethren, we have an opportunity for the first time in generations in this country for peace and prosperity. We have that opportunity without English soldiers marching up and down our streets and outside our churches on a Sunday morning. We have that opportunity because we have signed a treaty -- a treaty of peace. Catholic Priest: Quiet. Let me remind those of you who have forgotten of the pastoral letter signed by Cardinal Logue and other Bishops. Anti-Treatyite irregulars have, and I quote: ...wrecked Ireland from end to end, and all those who participate in such crimes are guilty of the gravest sins and may not be absolved in confession, nor admitted to Holy Communion. In other words: excommunication. And this opinion of the treaty is not just the opinion of the Catholic Church. It is the opinion of other churches. And it is the opinion of every newspaper up and down and the length and breadth of this country. But most importantly, this treaty was ratified -- overwhelmingly ratified -- by the people in their democratic expression in the June election. Damien: Can you tell me, Father, how there can be a fair election in this country when the most powerful country in the world threatens war? This is not the will of the people; it is the fear of the people. Catholic Priest: How dare you talk to me in the house of God. Catholic Priest: Silence! Damien O'Donovan, you're a disgrace to the memory of your parents. Yes, get out! Congregation Member: The Free-State Constitution was only printed the morning of the election. So nobody had time to -- Catholic Priest: Young lady, this is not the marketplace. Sit down! Shut up! Or get out my church! Damien: And once again, the Catholic Church, with honorable exception, sides with the rich. Catholic Priest: Get out!!",...
"- Observez, dit triomphalement le directeur, observez. Les livres et les bruits intenses, les fleurs et les secousses électriques, déjà, dans l'esprit de l'enfant, ces couples étaient liés de façon compromettante ; et, au bout de deux cents répétitions de la même leçon ou d'une autre semblable, ils seraient mariés indissolublement. Ce que l'homme a uni, la nature est impuissante à le séparer. - Ils grandiront avec ce que les psychologues appelaient une haine instinctive des livres et des fleurs. Des réflexes inaltérablement conditionnés. Ils seront à l'abri des livres et de la botanique pendant toute leur vie. - Le directeur se tourna vers les infirmières. - Remportez-les. Toujours hurlant, les bébés en kaki furent chargés sur leurs serveuses et roulés hors de la pièce, laissant derrière eux une odeur de lait aigre et un silence fort bien venu. L'un des étudiants leva la main ; et, bien qu'il comprît fort bien pourquoi l'on ne pouvait pas tolérer que des gens de caste inférieure gaspillant le temps de la communauté avec des livres, et qu'il y avait toujours le danger qu'ils lussent quelque chose qui fît indésirablement déconditionner un de leurs réflexes, cependant... en somme, il ne concevait pas ce qui avait trait aux fleurs. Pourquoi se donner la peine de rendre psychologiquement impossible aux Deltas l'amour des fleurs ?Patiemment, le directeur donna des explications. Si l'on faisait en sorte que les enfants se missent à hurler à la vue d'une rose, c'était pour des raisons de haute politique économique. Il n'y a pas si longtemps (voilà un siècle environ), on avait conditionné les Gammas, des Deltas, voire les Epsilons, à aimer les fleurs. Les fleurs en particulier et la nature sauvage en général. Le but visé, c'était de faire naître en eux le désir d'aller à la campagne chaque fois que l'occasion s'en présentait, et de les obliger ainsi à consommer du transport. - Et ne consommaient-ils pas de transport ? demanda l'étudiant. - Si, et même en assez grande quantité, répondit le directeur, mais rien de plus. Les primevères et les paysages, fit-il observer, ont un défaut grave : ils sont gratuits. L'amour de la nature ne fournit de travail à nulle usine. On décida d'abolir l'amour de la nature, du moins parmi les basses classes, mais non point la tendance à consommer du transport. Car il était essentiel, bien entendu, qu'on continuât à aller à la campagne, même si l'on avait cela en horreur. Le problème consistait à trouver à la consommation du transport une raison économiquement mieux fondée qu'une simple affection pour les primevères et les paysages. Elle fut dûment découverte. Nous conditionnons les masses à détester la campagne, dit le directeur pour conclure, mais simultanément nous les conditionnons à raffoler de tous les sports en plein air. En même temps, nous faisons le nécessaire pour que tous les sports de plein air entraînent l'emploi d'appareils compliqués. De sorte qu'on consomme des articles manufacturés, aussi bien que du transport. D'où ces secousses électriques. - Je comprends dit l'étudiant ; et il resta silencieux, éperdu d'admiration."};
nbmov = size(ltext,2);


entry = 0;
%{
fileID = fopen("sol-godot-cryptage.txt","w");  
for pp=1:13
  ii = randi(nbmov);
  src0 = ltext{ii}(1,:);
  pp
  for pos=20:50:length(src0)-20;
    entry = entry+1;
    Nok=1000000 + randi(1000000);     
    src = strcat(src0(1:pos),"Solutio est "," ",num2str(Nok),src0(pos+1:end));
    
    M = max(double(src));
    p=lp(randi(nbp));
    h1 = crypte(src,p)';
    nam=(277*entry)^2+entry + 282;
    filename = ["text_crypt/tirade_lucky",num2str(nam),".txt"];
    fid = fopen (filename, "w");
    for i=1:length(h1)
      fprintf(fid,"%i\n",h1(i));
    end
    fclose (fid);
    
    % d1 = decrypte(filename,p)
    
    fprintf(fileID,"footable[%i]:[%i,%i,%i];\n",entry,p,Nok,nam);
  endfor
endfor
fclose(fileID);
%}

for p=lp
  %if p>340 && p<379
    
    d1 = decrypte("exdata.txt",359)
    p
    pause(0.5);
  %end
end

endfunction