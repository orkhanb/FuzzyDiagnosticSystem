clc;
clear;

global    mu_xi;
altsinir_yas=0; ustsinir_yas=100;
altsinir_semptom=0; ustsinir_semptom=100;
 
tedavi_altsinir=0; tedavi_ustsinir=1;

sgn=[0.15 0.55 0.85];
 
Y=altsinir_yas:5:ustsinir_yas;
S=altsinir_semptom:5:ustsinir_semptom;

for i=1:size(Y,2)
    for j=1:size(S,2)
    
    
y = Y(i);   s = S(j);
yamuk(altsinir_yas,0,18,26,30,ustsinir_yas,y);  genc_xi=mu_xi; 
ucgen(altsinir_yas,22,33,50,ustsinir_yas,y);  orta_xi=mu_xi; 
yamuk(altsinir_yas,38,48,58,100, ustsinir_yas,y);  yasli_xi=mu_xi; 



%3. Semptomlara ait uyelik fonk girisleri ...
ucgen(altsinir_semptom,0,0,25,ustsinir_semptom,s);  semptom_az_xi=mu_xi; 
ucgen(altsinir_semptom,15,39,60,ustsinir_semptom,s);  semptom_orta_xi=mu_xi; 
ucgen(altsinir_semptom,50,69,85,ustsinir_semptom,s);  semptom_yuksek_xi=mu_xi; 
ucgen(altsinir_semptom,75,100,100,ustsinir_semptom,s);  semptom_cokyuksek_xi=mu_xi;


%cikish Tedavi
t0=0;
t1=sgn(1)*y+sgn(1)*s+sgn(1);%dinlenme
t2=sgn(2)*y+sgn(2)*s+sgn(2); %ilaclar
t3=sgn(3)*y+sgn(3)*s+sgn(3); %ameliyat


%Kurallar
w1=min(genc_xi, semptom_cokyuksek_xi);
w4=min(yasli_xi,semptom_yuksek_xi);
w7=min(orta_xi,semptom_cokyuksek_xi);
w8=min(yasli_xi,semptom_cokyuksek_xi);
w10=min(genc_xi,semptom_yuksek_xi);
w11=min(orta_xi,semptom_yuksek_xi);
w13=min(genc_xi,semptom_az_xi);
w15=min(genc_xi,semptom_orta_xi);
w16=min(orta_xi,semptom_orta_xi);

w17=min(orta_xi,semptom_az_xi);
w18=min(yasli_xi,semptom_az_xi);
w19=min(yasli_xi,semptom_az_xi);
w20=min(yasli_xi,semptom_orta_xi);





SAT = w1*t1+w4*t2+w7*t3+w8*t3+w10*t2+w11*t2+w13*t1+w15*t1+w16*t3+w17*t1+w18*t1+w19*t1+w20*t1;


toplam_agirlik = w1+w4+w7+w8+w10+w11+w13+w15+w16+w17+w18+w19+w20;
if toplam_agirlik == 0
    'Agirlik 0 a esit';
end
    
    z(j,i) = SAT/toplam_agirlik;
    end
    
end

%0 da cizdirme
surf(Y,S,z)
xlabel('yas');
ylabel('semptom');
zlabel('Tedavi');
