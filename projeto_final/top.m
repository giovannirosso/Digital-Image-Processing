%GIOVANNI DE ROSSO UNRUH
%FRANKLIN TAVARES

close all;
clear all;
%pkg load image;

I = imread("Prova/prova_f.jpeg");

I = imresize(I, [2970 2100]);
R = I(:, :, 1); % REd
%figure;
%imshow(R);

%I = imread("testeFoto2.png");
%I = rgb2gray(I);

Ibw = ~adaptive_threshold(R, 1000, 200); %Janela / Passo, tentar(500 / 50)%Usar para fotografias
%Ibw = ~im2bw(R,graythresh(R));           %Usar para imagem perfeita do PC

% figure;
% imshow(Ibw); %Visualizar imagem processada

Ifill = imfill(Ibw, 'holes'); %preenche vazios com 1
Iarea = bwareaopen(Ifill, 500); %remove todos objetos da imagem com menos de X pixels de AREA
Ifinal = bwlabel(Iarea); %marca grupos de "1's" sequencialmente como grupo 1, 2, 3, ...
estrutura = regionprops(Ifinal, 'boundingbox'); %struct estrutura [PosX,PosY,TamX,TamY] de cada quadrado detectado

figure;
imshow(I);
hold on;

numeroElementos = numel(estrutura);
mamada = ones(numeroElementos, 4);

counter = 1;
image_squares_marked = zeros(50, 5);
test_type = zeros(1,4);

for cont = 1:numeroElementos
    coordenada = estrutura(cont).BoundingBox;

    if (coordenada(3) * coordenada(4) > 9001)%BORDAS
        rectangle('position', coordenada, 'edgecolor', 'r', 'linewidth', 3);
    end

    if (coordenada(3) * coordenada(4) > 5500 && coordenada(3) * coordenada(4) < 9000)%Quadrados de tipo
        rectangle('position', coordenada, 'edgecolor', 'b', 'linewidth', 3);        
        %verifica o tipo de teste
        gzinho = I(round(coordenada(2):coordenada(2)+coordenada(4)), round(coordenada(1):coordenada(1)+coordenada(3)));
        gzinho = im2bw(gzinho, graythresh(gzinho));
        temp = mean(gzinho(:));
        if(temp < 0.6)        
          if((coordenada(1) < 750 + 20) && (coordenada(1) > 750 - 20))
            test_type(1) = 1;
            type = 1;
          elseif((coordenada(1) < 912 + 20) && (coordenada(1) > 912 - 20))
            test_type(2) = 1;
            type = 2;
          elseif((coordenada(1) < 1067 + 20) && (coordenada(1) > 1067 - 20))
            test_type(3) = 1;
            type = 3;
          elseif((coordenada(1) < 1224 + 20) && (coordenada(1) > 1224 - 20))
            test_type(4) = 1;
            type = 4;
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
        gzinho = I(round(yi:yf), round(xi:xf));
        gzinho = im2bw(gzinho, graythresh(gzinho));
        temp = mean(gzinho(:));
        %a media pro nao marcado e 0.73
        %testado com Folha_teste_perfeitinha.png
        marked = temp < 0.6;
        %se tiver marcado encontra qual foi
        %fazendo um cruzamento da posicao x
        %com a posicao y
        if marked
            %printf("Marked elem: %d\n", counter);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%% 1 ate 25 %%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            rectangle('position', coordenada, 'edgecolor', 'g', 'linewidth', 3);
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
                            image_squares_marked(j, i) = 1;
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
                            image_squares_marked(j, i) = 1;
                        end
                        yp = yp + 102;  %MELHORAR VALOR 
                    end
                end
            end
        end
        counter = counter + 1;
        mamada(cont, :) = coordenada;
    end
end

%mostra como ficou a resposta
%image_squares_marked

%invalida mais de uma resposta por questao
for i = 1:50
  if(sum(image_squares_marked(i,:)) > 1)
    image_squares_marked(i,:) = 0;
  end
end
%image_squares_marked

%valida o tipo de teste
if (sum(test_type(:) > 1))
    error("Marcou mais de um tipo de teste");
elseif (sum(test_type(:) < 0))
    error("Nao marcou um tipo de teste");
end

gabarito = zeros(50,5);
gabarito_type = zeros(1,4);
%ler o gabarito
%processar o gabarito e colocar na variavel gabarito
auxiliar_code;

if (type ~= g_type)
  error("tipo de prova diferente do tipo do gabarito");
end

acertos = 0;

for i=1:50
  %printf("questao: %d -- gabarito: ", i);printf("%d", gabarito(i,:));printf("-- prova: ");printf("%d",image_squares_marked(i,:));printf("\n");
  if gabarito(i,:) == image_squares_marked(i,:)
    acertos = acertos + 1;
  end
end

fprintf("Acertou %d questoes\n", acertos);