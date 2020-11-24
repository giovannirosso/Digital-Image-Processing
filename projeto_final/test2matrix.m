
% I = imread("Prova/prova_f.jpeg");
I = imread("Prova/prova_semPlanificar_N_Acerta_todas.jpeg");

I = imresize(I, [2970 2100]); 
R = I(:, :, 1); % REd
Ibw = ~adaptive_threshold(R, 1000, 200); %Janela / Passo, tentar(500 / 50)%Usar para fotografias
Ifill = imfill(Ibw, 'holes'); %preenche vazios com 1
Iarea = bwareaopen(Ifill, 500); %remove todos objetos da imagem com menos de X pixels de AREA
Ifinal = bwlabel(Iarea); %marca grupos de "1's" sequencialmente como grupo 1, 2, 3, ...
estrutura = regionprops(Ifinal, 'boundingbox'); %struct estrutura [PosX,PosY,TamX,TamY] de cada quadrado detectado
numeroElementos = numel(estrutura);
m1 = zeros(50,3);
counter = 1;

xmat = zeros(10,1);
xmat_pos = 1;
ymat = zeros(25,1);
ymat_pos = 1;

for i=1:numeroElementos
    temp = estrutura(i).BoundingBox;
    if (temp(3) * temp(4) > 3000 && temp(3) * temp(4) < 4000)%Quadrados
        xi = temp(1);
        yi = temp(2);
        xf = temp(1) + temp(3);
        yf = temp(2) + temp(4);
        gzinho = I(round(yi:yf), round(xi:xf));
        gzinho = im2bw(gzinho, graythresh(gzinho));
        if mean(gzinho(:)) < 0.6            
            m1(counter, 3) = 1;
            m1(counter,1:2) = temp(1:2);
            counter = counter + 1;
        end        
        
        xmat(xmat_pos) = xi;
        xmat_pos = xmat_pos+1;
        
        ymat(ymat_pos) = yi;
        ymat_pos = ymat_pos+1;       
        
    end
end

m2 = zeros(10,1);
xpos = 0;
xind = 1;
thresh = 30;

m3 = zeros(25,1);
ypos = 0;
yind = 1;
y_thresh = 30;

for i=1:10
    temp = xmat(xmat(:,1) > xpos+thresh , 1);
    if ~isempty(temp)
        xpos = min(temp);
        m2(xind)= xpos;
        xind = xind + 1;
    end
end

for i=1:25
    temp = ymat(ymat(:,1) > ypos+y_thresh , 1);
    if ~isempty(temp)
        ypos = min(temp);
        m3(yind)= ypos;
        yind = yind + 1;
    end
end

m4 = zeros(50,5);
for i=1:50
    if m1(i,3)
        if m1(i,1) <= m2(5)            
            for a=1:5
                if ((m1(i,1) <= (m2(a) + thresh)) && (m1(i,1) >= (m2(a) - thresh)))
                    for b=1:25
                        if ((m1(i,2) <= (m3(b) + y_thresh)) && (m1(i,2) >= (m3(b) - y_thresh)))
                            m4(b,a) = 1;
                        end
                    end
                end
            end            
        else            
            for a=1:5
                if ((m1(i,1) < m2(a+5) + thresh) && (m1(i,1) > m2(a+5) - thresh))
                    for b=1:25
                        if ((m1(i,2) < m3(b) + y_thresh) && (m1(i,2) > m3(b) - y_thresh))
                            m4(b+25,a) = 1;
                        end
                    end
                end
            end                        
        end
    end
end

for i = 1:50
  if(sum(m4(i,:)) > 1)
    m4(i,:) = 0;
  end
end
acertos = 0;
for i=1:50
  if gabarito(i,:) == m4(i,:)
    acertos = acertos + 1;
  end
end
fprintf("Acertou %d questoes\n", acertos);