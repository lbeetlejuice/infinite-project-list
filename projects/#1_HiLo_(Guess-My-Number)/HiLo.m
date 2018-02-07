
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WELCOME TO GAME OF HILO
% ~~~~~~~~~~~~~~~~~~~~~~~
%
% CREATED BY
% Lukas
% 
% DATE: 30.10.14
%
% DESCRIPTION
% Dies ist ein Spiel, in dem der Benutzer eine zufällig generierte Zahl 
% erraten muss. Dabei hat er eine Anzahl an Versuchen und das 
% Programm gibt Rückmeldung, ob die Zahl zu hoch oder zu tief
% geraten wurde.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Letztes Spiel auslesen; Spielregeln
clc
clear all
a = exist('memory.txt','file'); % 0 [does not exist] / else [does exist]
if (a == 0)
    disp('Willkommen zu HiLo!')
    disp('Dies ist dein erstes Spiel.')
else
    b = dlmread('memory.txt', '\t', 'A1..A1'); % letzte Zufallszahl
    c = dlmread('memory.txt', '\t', 'B1..B1'); % gewonnen 1 / verloren 0
    d = dlmread('memory.txt', '\t', 'C1..C1'); % Anzahl Versuche
    disp(['Letzes Mal musstest du die Zahl ' num2str(b) ' erraten'])
    if (c == 0)
        disp('was du leider nicht geschafft hast :-(')
    else
        disp(['was du hervorragend in ' num2str(d) ' Versuchen gelöst hast! :-)'])
    end
    disp([char(13) 'Hier nochmals die Spielregeln:'])
end

disp('HiLo bestimmt eine Zufallszahl zwischen Null')
disp('und einer von dir gewählten Grenze.')
disp('Versuche die Zahl zu erraten.')
disp('HiLo teilt dir mit, wieviele Versuche du noch hast')
disp('und ob du zu hoch oder zu tief geraten hast.')
disp('Viel Glück!')
disp([char(13) 'Taste drücken um weiterzufahren...']);
pause
clc

%% Eingabe Grenze; Vergabe Zufallszahl
disp('Gib eine Obergrenze ein')
p = input('und drück Enter: ','s');
p = str2double(p); % gibt NaN zurück, falls keine Zahl
if ((mod(p,1)~=0) || (isnan(p)) || (p < 0)) % überprüft, ob double, NaN oder minus
    fprintf(2, 'Das geht leider nicht.\nBitte gib eine positive ganze Zahl ein.\n');
%     break;
else 
    clc
    disp(['Bereich: 0 - ' num2str(p)]);
    n = randi(p); 
end 

%% Vergabe der Anzahl Versuche; Initialisierung effektive Versuche & Status
q = floor(log2(p))+1;

% disp(['Zufallszahl: ' num2str(n)])
disp(['Versuche: ' num2str(q)])

e = 1; % Anzahl Versuche
f = false; % gewonnen: false

%% Durchlauf Versuche; Überprüfen der Eingabe; Ausgabe ob Zahl <>=
while (q > 0) 
    
    r = input([char(13) num2str(e) '. Versuch: '],'s');
    r = str2double(r);
    if ((mod(r,1)~=0) || (isnan(r)) || (r < 0) || (r > p))
        fprintf(2, ['Das geht leider nicht.\nBitte gib eine ganze Zahl zwischen 0 und ' num2str(p) ' ein.\n']);
        break;
    end 
    
    if(r == n)
        disp('Jeee')
        f = true;
        break
    elseif(r < n)
        disp('Die Zahl ist zu tief...')
    elseif(r > n)
        disp('Die Zahl ist zu hoch...')
    end

    q = q - 1;
    e = e + 1;
end

%% Meldung gewonnen resp. verloren
if (f == false)
    g = [n 0 e];
    dlmwrite('memory.txt',g,'delimiter','\t')
    h = questdlg('Du hast verloren. Nochmals?',':-(','Ja','Nein','Ja');
else
    g = [n 1 e];
    dlmwrite('memory.txt',g,'delimiter','\t')
    h = questdlg('Du hast gewonnen! Nochmals?',':-)','Ja','Nein','Ja');
end
    switch h
        case 'Ja'
            clc
            HiLo
        case 'Nein'
            disp('tschüüs')
    end
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VARIABELVERZEICHNIS
% 
% a     existiert memory.txt?
% b     Auslesen der ersten Position von memory.txt (Zufallszahl)
% c     Auslesen der zweiten Position von memory.txt (gewonnen/verloren)
% d     Auslesen der dritten Position von memory.txt (Anzahl Versuche)
% e     Counter, Anzahl Versuche
% f     gewonnen oder verloren (true/false)
% g     Daten, die in memory.txt geschrieben werden
% h     Nochmals spielen? (Ja/Nein)
% n     Zufallszahl zw. 0 und Grenze
% p     Obergrenze des Zahlenbereiches
% q     Anzahl Versuche
% r     Eingabe der Rateversuche
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%