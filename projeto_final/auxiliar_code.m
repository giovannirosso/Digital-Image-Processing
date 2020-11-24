%fazer o set do gabarito aqui

%apenas para teste
%gabarito = image_squares_marked;

%Igabarito = imread("FOLHA_nova_preenchida_full.jpeg");
Igabarito = imread("Gabarito/gabarito_apre.jpeg");

Igabarito = imresize(Igabarito, [2970 2100]);

R = Igabarito(:, :, 1); % REd
Ibw = ~adaptive_threshold(R, 1000, 200); %Janela / Passo, tentar(500 / 50)%Usar para fotografias

Ifill = imfill(Ibw, 'holes'); %preenche vazios com 1
Iarea = bwareaopen(Ifill, 500); %remove todos objetos da imagem com menos de X pixels de AREA
Ifinal = bwlabel(Iarea); %marca grupos de "1's" sequencialmente como grupo 1, 2, 3, ...
estrutura = regionprops(Ifinal, 'boundingbox'); %struct estrutura [PosX,PosY,TamX,TamY] de cada quadrado detectado

figure;
imshow(Igabarito);
hold on;
title("imagem gabarito");

numeroElementos = numel(estrutura);

counter = 1;
gabarito = zeros(50, 5);
gabarito_type = zeros(1,4);

for cont = 1:numeroElementos
    coordenada = estrutura(cont).BoundingBox;

%    if (coordenada(3) * coordenada(4) > 9001)%BORDAS
%        rectangle('position', coordenada, 'edgecolor', 'r', 'linewidth', 3);
%    end

    if (coordenada(3) * coordenada(4) > 5500 && coordenada(3) * coordenada(4) < 9000)%Quadrados de tipo
        rectangle('position', coordenada, 'edgecolor', 'b', 'linewidth', 3);        
        %verifica o tipo de teste
        gzinho = Igabarito(round(coordenada(2):coordenada(2)+coordenada(4)), round(coordenada(1):coordenada(1)+coordenada(3)));
        gzinho = im2bw(gzinho, graythresh(gzinho));
        temp = mean(gzinho(:));
        if(temp < 0.6)        
          if((coordenada(1) < 750 + 20) && (coordenada(1) > 750 - 20))
            gabarito_type(1) = 1;
            g_type = 1;
          elseif((coordenada(1) < 912 + 20) && (coordenada(1) > 912 - 20))
            gabarito_type(2) = 1;
            g_type = 2;
          elseif((coordenada(1) < 1067 + 20) && (coordenada(1) > 1067 - 20))
            gabarito_type(3) = 1;
            g_type = 3;
          elseif((coordenada(1) < 1224 + 20) && (coordenada(1) > 1224 - 20))
            gabarito_type(4) = 1;
            g_type = 4;
          end        
        end
    end

    if (coordenada(3) * coordenada(4) > 3000 && coordenada(3) * coordenada(4) < 4000)%Quadrados
        %rectangle('position', coordenada, 'edgecolor', 'g', 'linewidth', 3);
        %text(coordenada(1), coordenada(2), num2str(counter));
        xi = coordenada(1);
        yi = coordenada(2);
        xf = coordenada(1) + coordenada(3);
        yf = coordenada(2) + coordenada(4);
        gzinho = Igabarito(round(yi:yf), round(xi:xf));
        gzinho = im2bw(gzinho, graythresh(gzinho));
        temp = mean(gzinho(:));
        %a media pro nao marcado e 0.73
        %testado com Folha_teste_perfeitinha.png
        marked = temp < 0.6;
        %se tiver marcado encontra qual foi
        %fazendo um cruzamento da posicao x
        %com a posicao y
        if marked
            rectangle('position', coordenada, 'edgecolor', 'g', 'linewidth', 3);
            %printf("Marked elem: %d\n", counter);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% 1 ate 25 %%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            threshold_x = 30;
            threshold_y = 30;
            initial_x = 120;
            initial_y = 230;
            increment_x = 95; %distancia entre os quadrados em x
            increment_y = 45; %distancia entre os quadrados em y
            largura = 60;
            yp = initial_y - threshold_y;

            for i = 1:5
                %printf("Valor em X : %d < %d & %d < %d\n", initial_x + (increment_x * (i - 1)) + (largura * (i - 1)) - threshold_x, xi, xf, initial_x + (increment_x * (i - 1)) + (largura * (i)) + threshold_x);
                if ((xi > initial_x + (increment_x * (i - 1)) + (largura * (i - 1)) - threshold_x) && ... // COLUNA
                    xf < initial_x + (increment_x * (i - 1)) + (largura * (i)) + threshold_x)
                    for j = 1:25
                        %printf("Valor em Y : %d < %d & %d < %d\n", yp, yi, yf, initial_y + (increment_y * (j - 1)) + (largura * (j)) + threshold_y);
                        if ((yi > yp) && ... // LINHA
                            yf < initial_y + (increment_y * (j - 1)) + (largura * (j)) + threshold_y)
                            %printf("elem: %d coluna:%d linha:%d\n\n", counter, i, j);
                            gabarito(j, i) = 1;
                        end
                        yp = yp + 102;  %MELHORAR VALOR 
                    end
                end
            end

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%% 26 ate 50 %%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            middle_x = 1220;
            yp = initial_y - threshold_y;

            for i = 1:5
                %printf("Valor em X : %d < %d & %d < %d\n", middle_x + (increment_x * (i - 1)) + (largura * (i - 1)) - threshold_x, xi, xf, middle_x + (increment_x * (i - 1)) + (largura * (i)) + threshold_x);
                if ((xi > middle_x + (increment_x * (i - 1)) + (largura * (i - 1)) - threshold_x) && ... // COLUNA
                    xf < middle_x + (increment_x * (i - 1)) + (largura * (i)) + threshold_x)
                    for j = 26:50
                        %printf("Valor em Y : %d < %d & %d < %d\n", yp, yi, yf, initial_y + (increment_y * (j - 26)) + (largura * (j - 25)) + threshold_y);
                        if ((yi > yp) && ... // LINHA
                            yf < initial_y + (increment_y * (j - 26)) + (largura * (j - 25)) + threshold_y)
                            %printf("elem: %d coluna:%d linha:%d\n\n", counter, i, j - 25);
                            gabarito(j, i) = 1;
                        end
                        yp = yp + 102;  %MELHORAR VALOR 
                    end
                end
            end
        end
        counter = counter + 1;
    end
end

%mostra como ficou a resposta
%image_squares_marked

%invalida mais de uma resposta por questao
for i = 1:50
  if(sum(gabarito(i,:)) > 1)
    gabarito(i,:) = -1;
    error("Gabarito com mais de uma resposta");
  end
end

%valida o tipo de teste
if (sum(gabarito_type(:) > 1))
    error("Marcou mais de um tipo de gabarito");
elseif (sum(gabarito_type(:) < 0))
    error("Nao marcou um tipo de gabarito");
end