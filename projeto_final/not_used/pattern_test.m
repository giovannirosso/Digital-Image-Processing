##clear all;
##close all;
##clc;

pkg load image;

im1 = imread("pdi_project_form_clean.jpg");
figure;
imshow(im1);
hold on;

##top_pattern = imread("top_corner.jpg");
##cc = normxcorr2 (top_pattern, im1);
##[r, c] = find (cc == max (cc(:)))
##[w h] = size(top_pattern);
##rectangle('position',[r-w c-h 30 30],...
##          'curvature',[0,0],'edgecolor','g','linewidth',2);
##text(r-w, c-h, "top left");
##
##top_pattern = imread("top_right.jpg");
##cc = normxcorr2 (top_pattern, im1);
##[r, c] = find (cc == max (cc(:)))
##[w h] = size(top_pattern);
##rectangle('position',[c-w r-h 30 30],...
##          'curvature',[0,0],'edgecolor','g','linewidth',2);
##text(c-w, r-h, "top right");
##
##
##top_pattern = imread("bottom_right.jpg");
##cc = normxcorr2 (top_pattern, im1);
##[r, c] = find (cc == max (cc(:)))
##[w h] = size(top_pattern);
##rectangle('position',[c-w r-h 30 30],...
##          'curvature',[0,0],'edgecolor','g','linewidth',2);
##text(c-w, r-h, "bottom right");

top_pattern = imread("bottom_left.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x21 = c
y21 = r
rectangle('position',[x21 y21 1 1],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);
##rectangle('position',[c-w r-h 5 5],...
##          'curvature',[0,0],'edgecolor','g','linewidth',2);
##text(c-w, r-h, "bottom_left");


top_pattern = imread("bottom_right.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x22 = c
y22 = r
rectangle('position',[x22 y22 1 1],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

top_pattern = imread("top_right.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x12 = c
y12 = r
rectangle('position',[x12 y12 1 1],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

top_pattern = imread("top_corner.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x11 = c
y11 = r
rectangle('position',[x11 y11 1 1],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

%some helpful values
[dy dx] = size(im1); %length of paper may vary
distance_x = 0.84131 %(x12-x11)/dx %distance between x's top percent on page size
distance_y = 0.87077 %(y21-y11)/dy %distance between y's left percent on page size

first_square_x = 55
first_square_y = 162

distance_x_first_square = 0.080605 %(x11-first_square_x)/dx
distance_y_first_square = 0.016934 %(first_square_y-y11)/dy 

square_x_len = 0.064232 %51/dx          
square_y_len = 0.038324 %43/dy          

distance_x_squares = 0.045340 %36/dx 
distance_y_squares = 0.070410 %79/dy

%need to match with 55 and 162. x OK but not y
first_square_x = x11-distance_x_first_square*dx
first_square_y = -y11+distance_y_first_square*dy

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
          
disp("fim");
