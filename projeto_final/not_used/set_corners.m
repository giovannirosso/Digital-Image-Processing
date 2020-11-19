%primeiro
%script para encontrar os cantos da folha

pkg load image;

start_time = time;

##im1 = imread("pdi_project_form_clean.jpg");
##im1 = imread("form02.jpeg");
im1 = imread("testeFoto.png");
im1 = rgb2gray(im1);
figure;
imshow(im1);
hold on;

top_pattern = imread("bottom_left.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x21 = c
y21 = r
rectangle('position',[x21 y21 10 10],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

top_pattern = imread("bottom_right.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x22 = c
y22 = r
rectangle('position',[x22 y22 10 10],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

top_pattern = imread("top_right.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x12 = c
y12 = r
rectangle('position',[x12 y12 10 10],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

top_pattern = imread("top_corner.jpg");
cc = normxcorr2 (top_pattern, im1);
[r, c] = find (cc == max (cc(:)));
x11 = c
y11 = r
rectangle('position',[x11 y11 10 10],...
          'curvature',[0,0],'edgecolor','g','linewidth',2);

printf("program took: %.02fs\n", time-start_time);
