
%this a qubigami coding
% input:
%       .txt file contain a text message  
%       long of hex messages should be (2*2=4 4*4=8 8*8=64 16*16=256 or...) 
% output:
%        sguare cipher text file with 2^n*2^n dimension. 
clc;
clear;
ID=fopen('message.txt');
hex=(dec2hex(uint8(fscanf(ID,'%c'))))';
hex=(hex(:))';
str_hex = hex2dec(split(hex,''));
str_hex =flipud(str_hex(2:end-1,:));   %seperate 0 from begining and end 
vector=zeros(1,1,length(str_hex));
vector(1,1,1:end)=str_hex(:,1);        

hight = length(vector);
dim_square=sqrt(length(vector));
%--------- first fold((r)ight 2 (l)eft)----------------- 
new_hight=hight/2;                                             
rev_half1=flip(flipud(vector(:,:,new_hight+1:end)),3);                     
half2=vector(:,:,1:new_hight);              
r2l_folded=horzcat(rev_half1,half2);                          
%--------- second fold((d)own 2 (u)p)------------------  ----
new_hight=new_hight/2;
rev_half1=flip((flipud(r2l_folded(:,:,new_hight+1:end))),3);
half2=r2l_folded(:,:,1:new_hight);
d2u_folding=vertcat(rev_half1,half2);

while new_hight~=1  % Continues until we have a square
    %---------------- right2left fold--------------------------------
    new_hight=new_hight/2;
    rev_half1=flip(fliplr(d2u_folding(:,:,new_hight+1:end)),3);
    half2=d2u_folding(:,:,1:new_hight);
    r2l_folding=horzcat(rev_half1,half2);
    %---------------- down2up fold----------------------------------
    new_hight=new_hight/2;
    rev_half1=flip(flipud(r2l_folding(:,:,new_hight+1:end)),3);
    half2=r2l_folding(:,:,1:new_hight);
    d2u_folding=vertcat(rev_half1,half2);
end
square=d2u_folding;
str=dec2hex(square);
msg=reshape(str,dim_square,dim_square);
file = fopen('cipher.txt', 'wt');
for i = 1:dim_square
    fprintf(file,msg(i,:));
    fprintf(file,'\n');
end
 fclose(file);

