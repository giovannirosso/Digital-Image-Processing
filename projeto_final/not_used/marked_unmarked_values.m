%terceiro
%script para testar o valor medio de um 
%quadrado marcado e desmarcado.

%some tests
bw = im2bw(im1, graythresh(im1));

figure(2);
imshow(bw);

%value of a unmarked square
first_square = bw(first_square_y:first_square_y+square_y_len ,first_square_x:first_square_x+square_x_len);
unmarked = 0;
for i = 1:length(first_square(:))
  if !first_square(i)
    unmarked = unmarked+1;
  endif
endfor
unmarked %860

figure(3);
imshow(first_square);

%marking first square
bw(first_square_y:first_square_y+square_y_len ,first_square_x:first_square_x+square_x_len) = 0;
figure(2);
imshow(bw);
%value of a marked square
first_square = bw(first_square_y:first_square_y+square_y_len ,first_square_x:first_square_x+square_x_len);
marked = 0;
for i = 1:length(first_square(:))
  if first_square(i) == true
    marked = marked+1;
  endif
endfor
marked %0