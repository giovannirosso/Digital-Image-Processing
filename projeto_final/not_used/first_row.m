%quarto
%teste de verificar os 5 quadrados da primeira fila

set_corners;
base_values;

%find better treshold
bw = im2bw(im1, graythresh(im1));

global dx;
global dy;
global first_square_x;
global first_square_y;

figure;
hold on;

square_x = first_square_x;
square_y = first_square_y;

marked = 0;
lesser_mean = 9999;

for j = 1:5

  square = bw(round(square_y:(square_y+square_y_len*dy)) , round(square_x:(square_x+square_x_len*dx)));
  square_mean = 0;
  for i = 1:length(square(:))
    if !square(i)
      square_mean = square_mean+1;
    endif
  endfor
  square_mean
  if square_mean < lesser_mean
    marked = j;
    lesser_mean = square_mean;
  endif

  imshow(square);
  pause;

  square_x = ((square_x + distance_x_squares*dx))

endfor

printf("User marked box %d\n", marked);