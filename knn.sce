//Nome : Eddy Rene Caceres Huacarpuma

//funcion euclidiana
function output = euclidian(x1,x2,y1,y2)  
     output = sqrt((x1-x2)^2 + (y1-y2)^2);
endfunction
//le a data c
function output = readFile()
    M=csvRead("data\data_total2.txt", ',');
    output = M; 
endfunction
//le as etiquetas da teste
function output = labelSet()
    M=csvRead("data\label.txt", ',');
    output = M; 
endfunction
// normaliza a data inicial e separa para training e teste
function a = trainSet()
    matrix=readFile();
    maxCol1= max(matrix(:,1))
    minCol1= min(matrix(:,1))  
    maxCol2= max(matrix(:,2))  
    minCol2= min(matrix(:,2))  
    newCol1 = (matrix(:,1) - minCol1)/(maxCol1-minCol1);
    newCol2 = (matrix(:,2) - minCol2)/(maxCol2-minCol2);
    //b = list (minCol1, maxCol1,minCol2,maxCol2);
    //disp(newCol2);
    matrix(:,1)=newCol1;
    matrix(:,2)=newCol2;
    train=matrix(1:40,:);
    test =matrix(41:60,:); 
    a = list(train , test);
endfunction
//grafica o data inicial 
function graficar_inicio()
    data=trainSet();
    x= data(1);
    y= data(2);
    a=[1:1:20];
        scatter(x(a,1),x(a,2),'red',"fill");
    b=[21:1:40];
        scatter(x(b,1),x(b,2),'blue',"fill");
    a=[1:1:10];
        scatter(y(a,1),y(a,2),'darkred',"fill");
    b=[11:1:20];
        scatter(y(b,1),y(b,2),'darkcyan',"fill");
    hl=legend(['train-lentilhas';'train-melancia';'test-lentilhas';'test-melancia'],2);
endfunction
//Grafica o resultado de teste
function graficar_resultado(x,y)
     a=[1:1:20];
         scatter(x(a,1),x(a,2),'red',"fill");
     b=[21:1:40];
         scatter(x(b,1),x(b,2),'blue',"fill");
    a=[1:1:10];
        scatter(y(a,1),y(a,2),'yellow',"fill");
    b=[11:1:20];
        scatter(y(b,1),y(b,2),'green',"fill");
    hl=legend(['train-lentilhas';'train-melancia';'test-lentilhas';'test-melancia'],2);
endfunction
//Algoritmo de knn
function output = knn(k)
    data=trainSet();
    x= data(1);
    t= data(2);
    rpta = ones(20,1);
    for i = 1:20;
        vect = ones(40,2);
        for j=1:40
          vect(j,1) =euclidian(t(i,1),x(j,1),t(i,2),x(j,2));
          vect(j,2) =x(j,3);
        end
        //disp(vect)
        vect= gsort(vect,'lr','i'); //ordena tudo de menor a maior, de acordo a primer col
        nn_vect = vect(1:k,:); // vizinho mais cercanos
        //disp(nn_vect);
        tmp= zeros(1,2);
        for m=1:k
            if(nn_vect(m,2) == 1) then
                tmp(1,1)=tmp(1,1)+1;
            else
                tmp(1,2)=tmp(1,2)+1;
            end
        end
        [val ind]=max(tmp);
        rpta(i,1)=ind;  
    end   
    t(:,3)=rpta;
    //graficar_resultado(x,t);
    output = rpta;
endfunction
//Error meio quadratico 
function salida = errorQuadratico(prediccao, label)
    error= 1000;
    error=sum((prediccao-label)^2)/20;
    salida=error;
endfunction

//Emcontra o melhores valores k para o menor error. 
function graphErros()    
    label=labelSet();
    errVect=[];
    for i=1:1:40
        pred=knn(i);
        errVect(i)=errorQuadratico(pred,label);
    end
    j =[1:1:40]; 
    errVect=errVect';
    disp(j)
    disp(errVect)
    plot(j, errVect, '-')
end


// *******************************************************// 


figure(1)
graficar_inicio()
figure(2)
knn(8)
//execucao do erros, comentar linea 89 "graficar_resultado(x,t);"  para nao mostrar todas as gráficas
graphErros();



