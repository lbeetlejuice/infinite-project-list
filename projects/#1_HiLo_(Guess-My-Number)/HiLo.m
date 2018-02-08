
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
% This is a game where the user has to guess a randomly generated number. 
% He has a number of attempts and the program gives feedback if the number 
% was too high or too low.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Read out last game; Rules of the game
clc
clear all
a = exist('memory.txt','file'); % 0 [does not exist] / else [does exist]
if (a == 0)
    disp('Welcome to HiLo!')
    disp('This is your first game.')
else
    b = dlmread('memory.txt', '\t', 'A1..A1'); % last random number
    c = dlmread('memory.txt', '\t', 'B1..B1'); % won 1 / lost 0
    d = dlmread('memory.txt', '\t', 'C1..C1'); % Number of attempts
    disp(['Last time you had to guess the number ' num2str(b)])
    if (c == 0)
        disp('what you have not managed to do :-(')
    else
        disp(['which you did excellently in ' num2str(d) ' attempts! :-)'])
    end
    disp([char(13) 'Here again the rules of the game:'])
end

disp('HiLo determines a random number between zero')
disp('and one of your chosen limits.')
disp('Try to guess the number.')
disp('HiLo tells you how many attempts you have left.')
disp('and whether you have gone too high or too low.')
disp('Good luck!')
disp([char(13) 'Press any key to continue...']);
pause
clc

%% Input limit; assignment of random number
disp('Enter an upper limit')
p = input('and press Enter: ','s');
p = str2double(p); % returns NaN if there is no number
if ((mod(p,1)~=0) || (isnan(p)) || (p < 0)) % checks if double, NaN or minus
    fprintf(2, 'This is not possible. \nPlease enter a positive integer.\n');
%     break;
else 
    clc
    disp(['Range: 0 - ' num2str(p)]);
    n = randi(p); 
end 

%% Assignment of the number of attempts; initialization of effective attempts & status
q = floor(log2(p))+1;

% disp(['Randomnumber: ' num2str(n)])
disp(['Attempts: ' num2str(q)])

e = 1; % Number of attempts
f = false; % won: false

%% Run tests; check the input; output if number <>=
while (q > 0) 
    
    r = input([char(13) num2str(e) '. Attempt: '],'s');
    r = str2double(r);
    if ((mod(r,1)~=0) || (isnan(r)) || (r < 0) || (r > p))
        fprintf(2, ['This is not possible. \nPlease enter an integer between 0 and ' num2str(p) '\n']);
        break;
    end 
    
    if(r == n)
        disp('Yeeei')
        f = true;
        break
    elseif(r < n)
        disp('The number is too low...')
    elseif(r > n)
        disp('The number is too high...')
    end

    q = q - 1;
    e = e + 1;
end

%% Message won or lost
if (f == false)
    g = [n 0 e];
    dlmwrite('memory.txt',g,'delimiter','\t')
    h = questdlg('You have lost. Again?',':-(','Yes','No','Yes');
else
    g = [n 1 e];
    dlmwrite('memory.txt',g,'delimiter','\t')
    h = questdlg('You won! Again?',':-)','Yes','No','Yes');
end
    switch h
        case 'Yes'
            clc
            HiLo
        case 'No'
            disp('Ok bye')
    end
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VARIABLE DIRECTORY
% 
% a     exists memory. txt?
% b     Read out the first position of memory.txt (random number)
% c     Read out the second position of memory.txt (won/lost)
% d     Read out the third position of memory.txt (number of attempts)
% e     Counter, number of attempts
% f     won or lost (true/false)
% g     Data written in memory.txt
% h     Play again? (Yes/No)
% n     Random number between 0 and limit
% p     Upper limit of the number range
% q     Number of attempts
% r     Entering the attempts
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%