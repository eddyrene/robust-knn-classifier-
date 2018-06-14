//hito 1 
//Aluno: Eddy René Cáceres Huacarpuma

function  s= convertToGray(im)
    s= im(:,:,1)/3 + im(:,:,2)/3 + im(:,:,3)/3;  
endfunction

function output = limiarize(input)
    im1 = input(:,:);
    im = convertToGray(im1);    
    im=(im<255)*1; 
    output=im;
endfunction

function output =area(input)
// Description of area(input)
    im = input(:,:);
    dd= (im==1)*1; 
    output=sum(dd);
endfunction

function output = euclidian(x1,x2,y1,y2)  
// Description of euclidian(input)  
 output = sqrt((x1-x2)^2 + (y1-y2)^2);
endfunction

function output = diameter(input)
// Description of diameter(input)
    tam=size(input)(1);
    tmp=0;
    for i=1:tam
        x_p= a(i,1); y_p=a(i,2);
        for j=i+1:tam // só sobre o triangulo superior da matriz de adjacencias
            x_t= a(j,1);
            y_t= a(j,2);
            tmp1= euclidian(x_p,x_t,y_p,y_t);
            if(tmp1>tmp) then //almacena o maior da todas as comparações
                tmp=tmp1;
            end
        end
    output=tmp;
    end
end

clc;
scicv_Init();
chdir('C:\Users\mica\Desktop\PDI\trabFinal\');
exec('follow.sci')

//fid = mopen("result/data_lentilha.txt", "w"); //save results in file
fid = mopen("result/data_melancia.txt", "w"); //save results in file
if (fid == -1)
  error('cannot open file for writing');
end
mfprintf(fid," ID Area Diameter \n");

for n=1:30
    //name= strcat(['Lentilha_Melancia/lentilha_',string(n),'.png']); // lentilla
    name= strcat(['Lentilha_Melancia/melancia_',string(n),'.png']); // melancia 
    obj = imread(name);
    r1= limiarize(obj);
    valArea= area(r1);   // valor da área
    [x y] = follow(r1);
    //plot2d(x,y);  // graficar os puntos do perímetro
    a =[x y];
    valDiam = diameter(a); // valor do diámetro 
    //disp(valDiam);
    mfprintf(fid, "%d, %d, %f \n", n,valArea  ,valDiam);
end
mclose(fid);