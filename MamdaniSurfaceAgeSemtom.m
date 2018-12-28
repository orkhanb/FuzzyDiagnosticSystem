clc;
clear;

global X mu_X  mu_xi;
altsinir_yas=0; ustsinir_yas=100;
altsinir_semptom=0; ustsinir_semptom=100;
 
tedavi_altsinir=0; tedavi_ustsinir=100;

Y=altsinir_yas:5:ustsinir_yas;
S=altsinir_semptom:5:ustsinir_semptom;

for i=1:size(Y,2)
    for j=1:size(S,2)
    toplam_agirlik = 0;
     y = Y(i);   s = S(j);
    yamuk(altsinir_yas,0,18,26,30,ustsinir_yas,y);  genc_xi=mu_xi; 
    ucgen(altsinir_yas,22,33,50,ustsinir_yas,y);  orta_xi=mu_xi; 
    yamuk(altsinir_yas,38,48,58,100, ustsinir_yas,y);  yasli_xi=mu_xi; 


    ucgen(altsinir_semptom,0,0,25,ustsinir_semptom,s);  semptom_az_xi=mu_xi; 
    ucgen(altsinir_semptom,15,39,60,ustsinir_semptom,s);  semptom_orta_xi=mu_xi; 
    ucgen(altsinir_semptom,50,69,85,ustsinir_semptom,s);  semptom_yuksek_xi=mu_xi; 
    ucgen(altsinir_semptom,75,100,100,ustsinir_semptom,s);  semptom_cokyuksek_xi=mu_xi;

    ucgen2(tedavi_altsinir,0,15,30,tedavi_ustsinir); dinlenme_mu=mu_X;
    ucgen2(tedavi_altsinir,25,55,80,tedavi_ustsinir);  ilaclar_mu=mu_X;
    ucgen2(tedavi_altsinir,70,85,100,tedavi_ustsinir);  ameliyat_mu=mu_X;
    
    %kurallar
    mu_kural1=min(genc_xi,semptom_cokyuksek_xi);
    mu_kural4=min(yasli_xi,semptom_yuksek_xi);
    mu_kural7=min(orta_xi,semptom_cokyuksek_xi);
    mu_kural8=min(yasli_xi,semptom_cokyuksek_xi);
    mu_kural10=min(genc_xi,semptom_yuksek_xi);
    mu_kural11=min(orta_xi,semptom_yuksek_xi);
    mu_kural13=min(genc_xi,semptom_az_xi);
    mu_kural15=min(genc_xi,semptom_orta_xi);
    mu_kural16=min(orta_xi,semptom_orta_xi);
    
    w1=min(orta_xi,semptom_az_xi)*ilaclar_mu;
    
    w2=min(yasli_xi,semptom_az_xi)*ameliyat_mu;
    w3=min(yasli_xi,semptom_az_xi)*dinlenme_mu;
    w4=min(yasli_xi,semptom_orta_xi)*ameliyat_mu;
    w5=min(yasli_xi,semptom_orta_xi)*dinlenme_mu;
   

    
    %Gerektirme islemi ile Tedavi kurallara ait sonuc kumelerinin belirlenmesi
        %gerektirme operatoru olarak prod * kullanilmistir
        %%%%%%%%%%%%%
        mu_sonuc1=mu_kural1*dinlenme_mu;
        mu_sonuc4=mu_kural4*ilaclar_mu;
        mu_sonuc7=mu_kural7*ameliyat_mu;
        mu_sonuc8=mu_kural8*ameliyat_mu;
        mu_sonuc10=mu_kural10*ilaclar_mu;
        mu_sonuc11=mu_kural11*ilaclar_mu;
        mu_sonuc13=mu_kural13*dinlenme_mu;
        mu_sonuc15=mu_kural15*dinlenme_mu;
        mu_sonuc16=mu_kural16*ameliyat_mu;

        %Tedavi birlestirme operatoru olarak max kullanilmistir
        
        
        
        a=max(max(max(max(mu_sonuc1,mu_sonuc4),max(mu_sonuc7,mu_sonuc8)),max(max(mu_sonuc10,mu_sonuc11),max(mu_sonuc13,mu_sonuc15))),mu_sonuc16);
         mu_birlestirme1=max(max(a,max(max(w1,w2),max(w3,w4))),w5);
toplam_alan=sum(mu_birlestirme1); 
if toplam_alan==0
    'Agirlk merkezi yonteminde toplam alan 0 dir';
end
    z(j,i) = sum(mu_birlestirme1.*X)/toplam_alan;
    end
end

[y,s] = meshgrid(Y,S);
surf(y,s,z)
xlabel('yas');
ylabel('semptom');
zlabel('Tedavi');
